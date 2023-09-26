import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/device/device_registration.dart';
import 'package:vlivemooc/core/helpers/play_state.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/models/content/content_model/contentdetail.dart';
import 'package:vlivemooc/core/models/content/package/package_model/package_model.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/payments/payments_service.dart';
import 'package:vlivemooc/core/player/play_button_state.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';
import 'package:vlivemooc/core/storage/device_storage.dart';
import 'package:vlivemooc/ui/components/player/web_player.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../ui/components/helpers/cross_platform_web_view.dart';
import '../../ui/components/helpers/link_launcher_web.dart';
import '../../ui/constants/constants.dart';
import '../../ui/routes/routes.dart';
import '../models/content/content_model/datum.dart';
import '../provider/user_provider.dart';

class PlayService {
  onPlayClick(
      {required BuildContext context,
      required PlayState playState,
      required Datum content,
      required Function onLoadCallback}) async {

    try{
      UserProvider userProvider = Provider.of<UserProvider>(context);
      bool isLoggedin = userProvider.isLoggedIn;
      if(!isLoggedin)
      {
        // required code for redirecting user
        final state = GoRouterState.of(context);
        userProvider.setRedirectLocation(state.location);
        // end of redirection
      }
    }catch(e){
      //Empty implemenenation as of now
    }



    if (playState.buttonState == PlayButtonState.login) {
      final state = GoRouterState.of(context);
      Provider.of<UserProvider>(context, listen: false)
          .setRedirectLocation(state.location);
      context.go(AppRouter.signup);
    } else if (playState.buttonState == PlayButtonState.play ||
        playState.buttonState == PlayButtonState.clearLead) {
      onLoadCallback(
          PlayState(buttonState: playState.buttonState, isLoading: true));
      await _playVideo(content, playState, onLoadCallback: onLoadCallback);
    } else if (playState.buttonState == PlayButtonState.subscribe) {
      onLoadCallback(PlayState(
          buttonState: playState.buttonState,
          buttonText: PlayButtonState.subscribe,
          isLoading: false));
      RouteGenerator().navigate(context, AppRouter.plans);
    } else if (playState.buttonState == PlayButtonState.buy) {
      onLoadCallback(PlayState(
        buttonState: playState.buttonState,
        isLoading: true,
      ));
      String url = await _generateCheckoutUrl(content);
      SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
      sharedPreferences.setString(DeviceStorage.purchaseListData, "");
      onLoadCallback(PlayState(
          buttonState: playState.buttonState,
          buttonText: PlayButtonState.buy,
          isLoading: false));
      _launchUrl(url, context);
    }
  }

  Future<Contentdetail> getPlatformMedia(Datum content) async {
    String streamtype = "DASH";
    Contentdetail? contentdetail;
    if (kIsWeb) {
      BrowserName browserName = await DeviceRegistration().getBrowserName();
      if (browserName == BrowserName.safari) {
        streamtype = "HLS";
      } else {
        streamtype = "DASH";
      }
    } else if (Platform.isIOS) {
      streamtype = "HLS";
    } else if (Platform.isAndroid) {
      streamtype = "DASH";
    } else {
      streamtype = "DASH";
    }
    List<Contentdetail> contentdetails = content.contentdetails!;
    for (var i = 0; i < contentdetails.length; i++) {
      Contentdetail detail = contentdetails[i];
      if (streamtype == detail.streamtype) {
        contentdetail = detail;
        break;
      }
    }
    contentdetail ??= content.contentdetails![0];
    return contentdetail;
  }

  _playVideo(Datum content, PlayState playState,
      {required Function onLoadCallback}) async {
    PackageModel packageModel = await NetworkHandler.getPackageDetail(content);
    bool isDrm = false;
    // if (playState.buttonState != PlayButtonState.clearLead) {
    //   AvailabilityService availabilityService = AvailabilityService();
    //   String mode = "";
    //   try {
    //     mode = await availabilityService.checkAvailability(content);
    //   } catch (err) {
    //     mode = PlayButtonState.notAvailable;
    //   }
    //   if (mode == AvailabilityService.paid ||
    //       mode == AvailabilityService.plan ||
    //       mode == AvailabilityService.rental) {
    //     isDrm = true;
    //   }
    // }
    if (packageModel.drmscheme![0].toString() != "NONE") {
      isDrm = true;
    }
    if (playState.buttonState == PlayButtonState.clearLead) {
      isDrm = false;
    }
    if (kIsWeb) {
      var params = await generateWebParams(content, packageModel,
          isDrm: isDrm, playState: playState);
      String encodedString = jsonEncode(params);
      if (kDebugMode) {
        print("Web params $encodedString");
      }

      String playerUrl = "${Uri.base.origin}/player.html?data=$encodedString";
      // String playerUrl = "http://[::]:8080/?data=$encodedString";
      onLoadCallback(
          PlayState(
              buttonState: playState.buttonState,
              buttonText: playState.buttonText,
              isLoading: false),
          playerUrl: playerUrl);
      // LinkLauncherWeb().launchUrlWeb(playerUrl);
    } else {
      const platform = MethodChannel("com.mobiotics.media");

      Map<String, dynamic> params;
      if (Platform.isAndroid) {
        params = await generateAndroidParams(content, packageModel);
      } else {
        //ios implementation here
        params = await generateiOSParams(content, packageModel);
      }
      try {
        onLoadCallback(
          PlayState(
              buttonState: playState.buttonState,
              buttonText: playState.buttonText,
              isLoading: false),
        );

        await platform.invokeMethod("openPlayer", params);
      } on PlatformException {
        //handle platfrom exception here
      }
    }
  }

  showWebPlayer(BuildContext context, String playerUrl, Datum content) {
    showModalBottomSheet(
        backgroundColor: AppColors.white.withOpacity(0.9),
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (ctx) {
          return WebPlayer(
            content: content,
            onClose: () {
              Navigator.pop(ctx);
            },
            playerUrl: playerUrl,
          );
        });
  }

  generateWebParams(Datum content, PackageModel packageModel,
      {required bool isDrm,
      required PlayState playState,
      bool isLive = false}) async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String sessionToken =
        sharedPreferences.getString(DeviceStorage.sessionToken) ?? "";

    bool renderLogo = !isLive;
    String userEmail = "";
    String profileid = "";
    String subscriberid = "";
    bool renderSecurity = true;

    if (sessionToken.isNotEmpty) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(sessionToken);
      if (decodedToken.containsKey('email')) {
        userEmail = decodedToken['email'];
      } else {
        userEmail = decodedToken['mobileno'];
      }
      subscriberid = decodedToken['subscriberid'];
      profileid = decodedToken['profileid'];
    }
    int position = 1;
    try {
      if (content.watchedDuration != null) {
        position = content.watchedDuration!.toInt();
      }
    } catch (err) {
      //do nothing
    }

    var scrubbing = {};
    try {
      scrubbing = packageModel.packagedfilelist!.scrubbing![0].toMap();
    } catch (nullCheckError) {
      //do nothing
    }
    int clearLead = content.contentdetails![0].clearlead ?? 0;
    if (playState.buttonState == PlayButtonState.play) {
      clearLead = 0;
    }

    return {
      "contentId": content.objectid,
      "contenttype": content.objecttype,
      "title": content.title,
      "description": content.shortdescription,
      "thumbnail": content.thumbnail,
      "source": [
        packageModel.streamfilename,
      ],
      "licenseServer":
          "https://vdrm.mobiotics.com/prod/${ProviderConstants.environment}/v1/license",
      "packageid": packageModel.packageid,
      "providerid": "enrichtv",
      "drmscheme": packageModel.drmscheme,
      "category": content.category ?? "",
      'availabilityid':
          content.contentdetails![1].availabilityset![0].toString(),
      "providerSession": sessionToken,
      "skip": "",
      "duration": content.duration,
      "genre": content.genre,
      "position": position,
      "contentTags": ['ct-music'],
      "scrubbing": scrubbing,
      "adversity": {
        "advisory": null,
        "pgrating": "ALL",
        "defaultgenre": "BUSINESS"
      },
      "isDrmContent": isDrm,
      "renderLogo": renderLogo,
      "userEmail": userEmail,
      'profileid': profileid,
      'poster': content.poster,
      'subscriberid': subscriberid,
      "renderSecurity": renderSecurity,
      "should_render_cancel": true,
      "leadTime": clearLead,
      "tokenApiURL":
          "https://vcms.mobiotics.com/${ProviderConstants.environment}/subscriber/v1/content/drmtoken"
    };
  }

  generateAndroidParams(Datum content, PackageModel packageModel) async {
    var contentData = content.toMap();
    contentData['contentStream'] = packageModel.toMap();

    Map<String, String> playerParams = {
      "content": jsonEncode(contentData),
      "licenseServer": "https://vdrm.mobiotics.com/prod/proxy/v1/license",
      "packageid": packageModel.packageid ?? "",
      "sessionToken": "",
      Constants.playerSecurity: await getPlaySecurityText(),
    };
    return playerParams;
  }

  generateiOSParams(Datum content, PackageModel packageModel) async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String sessionToken =
        sharedPreferences.getString(DeviceStorage.sessionToken) ?? "";
    Map<String, dynamic> playerParams = {
      "content": content.toMap(),
      "streamDetails": packageModel.toMap(),
      "startDuration": content.watchedDuration,
      "availabilityId":
          content.contentdetails![1].availabilityset![0].toString(),
      "providerId": ProviderConstants.providerid,
      "sessionToken": sessionToken,
      "licenseURL":
          "https://vdrm.mobiotics.com/${ProviderConstants.environment}/proxy/v1/license/fairplay",
      "drmTokenURL":
          "https://vcms.mobiotics.com/${ProviderConstants.environment}/subscriber/v1/content/drmtoken",
      "fairplayCertificatePath":
          "file:///private/var/containers/Bundle/Application/EF8ED0B1-CE6C-4721-9A60-77D9595FD5D2/MOBIPlayer-Noor-Clone.app/fairplay.cer",
      "defaultSubtitleLanguageCode": "",
      "persistenceSettings": {"audio": "", "subtitle": ""},
      Constants.playerSecurity: await getPlaySecurityText(),
    };
    return playerParams;
  }

  Future<String> _generateCheckoutUrl(Datum content) async {
    PaymentsService paymentsService = PaymentsService();
    String checkouturl = await paymentsService.generateCheckoutUrl(
      content,
      "PURCHASE",
    );
    return checkouturl;
  }

  _launchUrl(String url, BuildContext context) async {
    if (kIsWeb) {
      SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
      await sharedPreferences.setString(DeviceStorage.purchaseListData, "");
      await sharedPreferences.setString(DeviceStorage.subscriptionData, "");
      LinkLauncherWeb().launchUrlWeb(url);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CrossPlatformWebView(
                  url: url,
                  onResponse: (response) {
                    onPaymentMade(response, context);
                  })));
    }
  }

  onPaymentMade(response, context) async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    await sharedPreferences.setString(DeviceStorage.purchaseListData, "");
    await sharedPreferences.setString(DeviceStorage.subscriptionData, "");
  }

  Future<String> getPlaySecurityText() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String sessionToken =
        sharedPreferences.getString(DeviceStorage.sessionToken) ?? "";

    String playSecurityTxt = "";
    if (sessionToken.isNotEmpty) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(sessionToken);

      if (decodedToken.containsKey('email')) {
        playSecurityTxt = decodedToken['email'];
      } else {
        playSecurityTxt = decodedToken['mobileno'];
      }
    }

    if (Platform.isIOS) {
      String? ip = await getIpAddress();
      ip = ip ?? "";
      playSecurityTxt = "$playSecurityTxt\n$ip";
    }
    return playSecurityTxt;
  }

  Future<String?> getIpAddress() async {
    try {
      // Retrieve a list of network interfaces (e.g., Wi-Fi, Ethernet, etc.)
      List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false,
        includeLinkLocal: false,
        type: InternetAddressType.IPv4,
      );

      // Find the first non-loopback, non-link local interface with an IPv4 address
      NetworkInterface? selectedInterface;
      for (var interface in interfaces) {
        if (!interface.name.contains('lo') &&
            !interface.name.contains('vmnet') &&
            interface.addresses.isNotEmpty) {
          selectedInterface = interface;
          break;
        }
      }

      // Return the IP address
      return selectedInterface?.addresses.first.address;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting IP address: $e');
      }
      return null;
    }
  }
}
