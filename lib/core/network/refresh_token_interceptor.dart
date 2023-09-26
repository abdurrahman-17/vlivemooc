import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';
import 'package:vlivemooc/core/storage/device_storage.dart';

import 'network_handler.dart';

class AppTokenInterceptor extends QueuedInterceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = "application/x-www-form-urlencoded";
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String refreshToken =
        sharedPreferences.getString(DeviceStorage.refreshToken) ?? "";
    String sessionToken =
        sharedPreferences.getString(DeviceStorage.sessionToken) ?? "";
    String deviceToken =
        sharedPreferences.getString(DeviceStorage.deviceToken) ?? "";
    if (kDebugMode) {
      // print("deviceToken");
      // print(deviceToken);
      // print(sessionToken);
    }
    if (ProviderConstants.isLoggedIn) {
      if (NetworkHandler.hasTokenExpired(refreshToken)) {
        //logout the user
        NetworkHandler().logout();

        //add device token headers since the user is logged out
        if (NetworkHandler.hasTokenExpired(deviceToken)) {
          deviceToken = await NetworkHandler.refreshDeviceToken();
        }

        //print("add device token headers since the user is logged out");
        options.headers["authorization"] = 'Bearer $deviceToken';
      } else {
        if (NetworkHandler.hasTokenExpired(sessionToken)) {
          sessionToken = await NetworkHandler.refreshSessionToken(refreshToken);
        }
        if (sessionToken == "") {
          //logout the user the session was expired
          NetworkHandler().logout();
          if (NetworkHandler.hasTokenExpired(deviceToken)) {
            deviceToken = await NetworkHandler.refreshDeviceToken();
          }
          //print("add device token headers since the user is logged out");
          options.headers["authorization"] = 'Bearer $deviceToken';
        } else {
          // addd session token headers since the user is logged in
          //print("addd session token headers since the user is logged in");
          //print(sessionToken);
          options.headers["X-SESSION"] = sessionToken;
        }
      }
    } else {
      if (NetworkHandler.hasTokenExpired(deviceToken)) {
        deviceToken = await NetworkHandler.refreshDeviceToken();
      }
      // add device token headers since the user is not logged in
      options.headers["authorization"] = 'Bearer $deviceToken';
      //print("add device token headers since the user is not logged in");
    }
    handler.next(options);
  }

  onJWTExpired(DioException err, ErrorInterceptorHandler handler) async {
    await NetworkHandler.refreshDeviceToken(force: true);
    RequestOptions requestOptions = err.requestOptions;
    var response = await NetworkHandler.getInstance().request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
    return handler.resolve(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;

    if (kDebugMode) {
      // print("Api: ${err.requestOptions.path}");
      // print("Request Params: ${err.requestOptions.data}");
      // print("Api Response: ${response?.statusCode}");
      // print("Response: ${response?.data}");
    }

    //print("status code ${response!.statusCode} and data= ${response.data}");
    if (response == null) {
      return;
    }
    if (response.statusCode == 400) {
      var data = response.data;
      try {
        if (data['errorcode'] == 8601 &&
            data['reason'] == "Limit Reached. Please Try After Some Time") {
        await onJWTExpired(err, handler);
        } else if (data['errorcode'] == 6002 &&
            data['reason'] == "Invalid Credential") {
          handler.resolve(response);
        } else if (data['errorcode'] == 6110 &&
            (data['reason'] == "Verification Pending" ||
                data['reason'] == "Email Verification Pending")) {
          handler.resolve(response);
        } else if (data['errorcode'] == 8000 &&
            data['reason'] == "This Event has Expired") {
          handler.resolve(response);
        } else if (data['errorcode'] == 8003 &&
            data['reason'] == "Booking Slot not available") {
          handler.resolve(response);
        } else if (data['errorcode'] == 6001 /*&&
            data['reason'] == "Invalid User"*/) {
          handler.resolve(response);
        } else if (data['errorcode'] == 6401 &&
            data['reason'] == 'Mobile Number Not Valid') {
          handler.resolve(response);
        } else if (data['errorcode'] == 6005 &&
            data['reason'] == "Invalid Otp") {
          handler.resolve(response);
        } else if (data['errorcode'] == 6111) {
          handler.resolve(response);
        }
      } catch (keyerror) {
        //do nothing here
        //print("=>> keyerror $keyerror");
      }
    } else if (response.statusCode == 401) {
      var data = response.data;
      //RequestOptions options = err.requestOptions;

      //print("on 401 response =>");
      //print("response data is =... ${response.data}");
      //print("request data => ${options.data}");
      //print("request headers => ${options.headers}");
      //print("resues url => ${options.path}");
      /*
      {errorcode: 6066, reason: Cannot read property 'payload' of null}
      */
      try {
        if (data['errorcode'] == 6055 && data['reason'] == "jwt expired") {
          onJWTExpired(err, handler);
        }
      } catch (keyerror) {
        //do nothing here
        //print("=>> keyerror $keyerror");
      }
    } else {
      //RequestOptions options = err.requestOptions;

      if (kDebugMode) {
        // print("on ${response.statusCode} response =>");
        // print("response data is =... ${response.data}");
        // print("request data => ${options.data}");
        // print("request headers => ${options.headers}");
      }
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      // print("Api: ${response.requestOptions.path}");
      // print("Request Params: ${response.requestOptions.data}");
      // print("Api Response: ${response.statusCode}");
      // print("Response: ${response.data}");
    }
    super.onResponse(response, handler);
  }
}
