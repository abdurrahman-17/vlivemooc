import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/device/device_info.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';
import 'package:vlivemooc/core/storage/device_storage.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:crypto/crypto.dart' as crypto;

class DeviceRegistration {
  num _getRandomId() {
    int min = 100000;
    int max = 999999;
    return min + Random().nextInt((max + 1) - min);
  }

  Future<BrowserName> getBrowserName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo info = await deviceInfo.webBrowserInfo;
    return info.browserName;
  }

  Future<Map<String, String>> getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId = "";
    String? osVersion = "";
    String deviceType = "PC";
    String? deviceModel = "";
    if (kIsWeb) {
      WebBrowserInfo info = await deviceInfo.webBrowserInfo;
      deviceId = _getRandomId().toString();
      osVersion = "${info.platform} ${_getRandomId()}";
      deviceType = "PC";
      deviceModel = info.browserName.toString();
    }
    if (!kIsWeb && Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      deviceId = info.id;
      osVersion = info.version.release;
      deviceModel = info.model;
    } else if (!kIsWeb && Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      deviceId = (info.identifierForVendor != null)
          ? info.identifierForVendor
          : _getRandomId().toString();
      osVersion = info.systemName;
      deviceModel = info.model;
    } else {
      deviceId = _getRandomId().toString();
      osVersion = _getRandomId().toString();
      deviceModel = _getRandomId().toString();
    }

    String deviceOS = (!kIsWeb && Platform.isAndroid)
        ? "ANDROID"
        : (!kIsWeb && Platform.isIOS)
            ? "IOS"
            : (!kIsWeb && Platform.isWindows)
                ? "WINDOWS"
                : (!kIsWeb && Platform.isMacOS)
                    ? "MAC"
                    : "WEBOS";
    DeviceInfo.deviceid = deviceId ?? _getRandomId().toString();
    DeviceInfo.devicetype = deviceType;
    DeviceInfo.deviceos = deviceOS;
    DeviceInfo.osversion = osVersion;

    DeviceInfo.devicemodel = deviceModel;
    Map<String, String> params = {
      'deviceid': DeviceInfo.deviceid,
      "devicetype": deviceType,
      "providerid": ProviderConstants.providerid,
      "deviceos": deviceOS,
      "appversion": ProviderConstants.appVersion,
      "osversion": osVersion,
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
    };

    return params;
  }

  String _aes128EcbEncrypt(String plaintext, String key) {
    final encrypter =
        enc.Encrypter(enc.AES(enc.Key.fromUtf8(key), mode: enc.AESMode.ecb));
    final encrypted = encrypter.encrypt(plaintext, iv: enc.IV.fromLength(16));
    return encrypted.base64;
  }

  Future<String> registerDevice({bool force = false}) async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();

    if (!force) {
      String deviceTokenInStorage =
          sharedPreferences.getString(DeviceStorage.deviceToken) ?? "";
      if (!NetworkHandler.hasTokenExpired(deviceTokenInStorage)) {
        return deviceTokenInStorage;
      }
    }

    Map<String, String> params = await getDeviceInformation();
    String paramsString = jsonEncode(params);
    String encryptedParams =
        _aes128EcbEncrypt(paramsString, ProviderConstants.clientkey);
    String encryptedHash =
        crypto.sha1.convert(utf8.encode(paramsString)).toString();

    String deviceToken =
        await NetworkHandler().registerDevice(encryptedParams, encryptedHash);
    await sharedPreferences.setString(DeviceStorage.deviceToken, deviceToken);
    return deviceToken;
  }
}
