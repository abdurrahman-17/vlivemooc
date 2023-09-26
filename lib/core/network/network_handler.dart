import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/device/device_info.dart';
import 'package:vlivemooc/core/device/device_registration.dart';
import 'package:vlivemooc/core/models/availability/availability_model/availability_model.dart';
import 'package:vlivemooc/core/models/category/category_model/category.dart';
import 'package:vlivemooc/core/models/category/category_model/category_model.dart';
import 'package:vlivemooc/core/models/coaches/coach_model/instructor_sessions.dart';
import 'package:vlivemooc/core/models/content/chapters/chapters_model/chapters_model.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/content/content_model/contentdetail.dart';
import 'package:vlivemooc/core/models/content/modules/modules_model/modules_model.dart';
import 'package:vlivemooc/core/models/content/package/package_model/package_model.dart';
import 'package:vlivemooc/core/network/refresh_token_interceptor.dart';
import 'package:vlivemooc/core/network/urls.dart';
import 'package:vlivemooc/core/player/play_service.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/core/storage/device_storage.dart';
import '../../../core/models/coaches/coach_model/datum.dart';

import '../models/coaches/coach_model/coach_model.dart';
import '../models/coaches/events_model/events_model.dart';
import '../models/content/content_model/datum.dart' as content;
import '../models/plans/plans_model/plans_model.dart';
import '../models/profile/profile_model/profile_model.dart';
import '../models/subscriber/subscriber_model.dart';
import '../provider/provider_constants.dart';

class NetworkHandler {
  static const String post = "POST";
  static const String get = "GET";
  static BuildContext? appContext;
  static Dio? _dio;

  static Dio getInstance() {
    return _dio!;
  }

  static initialize() {
    _dio = Dio();
    _dio!.interceptors.add(AppTokenInterceptor());
  }

  static Future<bool> getLoginState() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String refreshToken =
        sharedPreferences.getString(DeviceStorage.refreshToken) ?? "";
    return !hasTokenExpired(refreshToken);
  }

  static Future<String> refreshSessionToken(String refreshToken) async {
    // if (hasTokenExpired(deviceToken)) {
    //   deviceToken = await refreshDeviceToken();
    // }
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = "application/x-www-form-urlencoded";
    dio.options.headers["authorization"] = 'Bearer $refreshToken';
    String url = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/refreshtoken";
    final Response response;
    try {
      response = await dio.get(url);
    } catch (error) {
      //this means the refresh token was revoked
      return "";
    }
    var data = response.data;
    String newSessionToken = data['success'];
    String newRefreshToken = data['refreshtoken'];

    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    await sharedPreferences.setString(
        DeviceStorage.sessionToken, newSessionToken);
    await sharedPreferences.setString(
        DeviceStorage.refreshToken, newRefreshToken);

    return newSessionToken;
  }

  static Future<String> refreshDeviceToken({bool force = false}) async {
    String deviceToken =
        await DeviceRegistration().registerDevice(force: force);
    return deviceToken;
  }

  static bool hasTokenExpired(String token) {
    if (token.isEmpty) {
      return true;
    }
    bool hasExpired = JwtDecoder.isExpired(token);
    return hasExpired;
  }

  Future<String> registerDevice(String body, String encryptedHash) async {
    Dio dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onError: (DioException err, handler) async {
      //to do add some kind of a fallback here
    }));
    String url =
        "${AppUrls.baseUrlVSMS}/subscriberv2/v1/device/register/${ProviderConstants.providerid}?hash=$encryptedHash";
    dio.options.headers['Content-Type'] = "text/plain;charset=UTF-8";
    final response = await dio.post(url, data: body);
    return response.data['success'];
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    ProviderConstants.isLoggedIn = false;
    await sharedPreferences.setString(DeviceStorage.refreshToken, "");
    await sharedPreferences.setString(DeviceStorage.deviceToken, "");
    await sharedPreferences.setString(DeviceStorage.sessionToken, "");
    await sharedPreferences.setString(DeviceStorage.countryInfo, "");
    await sharedPreferences.setString(DeviceStorage.purchaseListData, "");
    await sharedPreferences.setString(DeviceStorage.subscriptionData, "");
    await sharedPreferences.setString(DeviceStorage.availabilityData, "");
    await sharedPreferences.setString(DeviceStorage.subscriberData, "");
    await sharedPreferences.setString(DeviceStorage.plans, "");
    try {
      await GoogleSignIn().signOut();
    } catch (err) {
      // ignore
    }

    // try {
    //   await FacebookAuth.instance.logOut();
    // } catch (err) {
    //   // ignore
    // }

    Provider.of<UserProvider>(appContext!, listen: false).setIsLoggedIn(false);
    try {
      ScaffoldMessenger.of(appContext!)
          .showSnackBar(const SnackBar(content: Text("You were logged out")));
    } catch (scaffoldNotFoundException) {
      //  AppAlerts.showSessionTimedOut(appContext!);
    }
    return true;
  }

  static Future<dynamic> verifyUser(
      {required String email, required String phone}) async {
    String? url;
    if (email.isEmpty) {
      url = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/verifyuser?mobileno=$phone";
    } else {
      url = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/verifyuser?email=$email";
    }
    final response = await _dio!.get(url);
    return response.data;
  }

  static Future<String> createAccount(
      {String name = "",
      String email = "",
      String phone = "",
      String password = "",
      String? captcha,
      String? gtoken,
      String? fbtoken,
      String? appletoken}) async {
    String url = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/subscriber";
    await DeviceRegistration().getDeviceInformation();
    var body = {
      "subscribername": name.isEmpty ? null : name,
      "country": DeviceInfo.countryCode,
      "password": password.isEmpty ? null : password,
      "captcha": captcha ?? "",
      "deviceos": DeviceInfo.deviceos,
      "model": DeviceInfo.devicemodel,
      "email": email.isEmpty ? null : email,
      "mobileno": phone.isEmpty ? null : phone,
      "make": DeviceInfo.devicemodel,
      "version": ProviderConstants.appVersion,
      "devicetype": DeviceInfo.devicetype,
      "gtoken": gtoken,
      "fbtoken": fbtoken,
      "appletoken": appletoken,
    };
    final response = await _dio!.post(url, data: body);
    var data = response.data;
    return data['success'] as String;
  }

  static Future<Map<String, dynamic>> login(
      {String email = "",
      String mobileno = "",
      String password = "",
      String gToken = "",
      String fbToken = "",
      String otp = "",
      String appleToken = ""}) async {
    Map<String, dynamic> result = {};
    String base = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/login";
    String url = "";

    if (mobileno.isNotEmpty && otp.isNotEmpty) {
      url = "$base?mobileno=$mobileno&otp=$otp";
    }
    if (mobileno.isNotEmpty && password.isNotEmpty) {
      url = "$base?mobileno=$mobileno&password=$password";
    } else if (email.isNotEmpty && password.isNotEmpty) {
      url = "$base?email=$email&password=$password";
    } else if (gToken.isNotEmpty) {
      url = "$base?gtoken=$gToken";
    } else if (fbToken.isNotEmpty) {
      url = "$base?fbtoken=$fbToken";
    } else if (appleToken.isNotEmpty) {
      url = "$base?appletoken=$appleToken";
    }

    final response = await _dio!.get(url);
    if (response.statusCode == 200) {
      result['status'] = true;
      result['data'] = response.data;
      var data = response.data;
      SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
      String sessionToken = data['success'];
      String refreshToken = data['refreshtoken'];
      ProviderConstants.isLoggedIn = true;
      await sharedPreferences.setString(
          DeviceStorage.sessionToken, sessionToken);
      await sharedPreferences.setString(
          DeviceStorage.refreshToken, refreshToken);
    } else if (response.statusCode == 400) {
      result['status'] = false;
      result['data'] = response.data;
    } else {
      result['status'] = false;
      result['data'] = response.data;
    }

    return result;
  }

  static Future<Response> confirmEmailOrMobile({
    String email = "",
    String mobileno = "",
    String otp = "",
    String token = "",
  }) async {
    String url =
        "${AppUrls.baseUrlVSMS}/subscriberv2/v1/subscriber/emailconfirm";

    var body = {
      "email": email.isEmpty ? null : email,
      "mobileno": mobileno.isEmpty ? null : mobileno,
      "token": token.isEmpty ? null : token,
      "otp": otp.isEmpty ? null : otp,
    };

    body['providerid'] = ProviderConstants.providerid;
    final response = await _dio!.post(url, data: body);

    return response;
  }

  static getCountry() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String countryInfoStr =
        sharedPreferences.getString(DeviceStorage.countryInfo) ?? "";
    if (countryInfoStr.isNotEmpty) {
      var data = jsonDecode(countryInfoStr);
      DeviceInfo.countryCode = data['CountryCode'];
      DeviceInfo.countryName = data['CountryName'];
      return;
    }

    String url = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/getcountry";
    final response = await _dio!.get(url);
    var data = response.data;
    DeviceInfo.countryCode = data['CountryCode'];
    DeviceInfo.countryName = data['CountryName'];
    await sharedPreferences.setString(
        DeviceStorage.countryInfo, jsonEncode(data));
  }

  static resendEmailOrPhoneVerification(
      {required String email, required String phone}) async {
    String url = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/resend";
    var body = {
      "email": email.isEmpty ? null : email,
      "mobileno": phone.isEmpty ? null : phone
    };
    final response = await _dio!.post(url, data: body);
    return response;
  }

  static Future<Response<dynamic>> forgotPassword({
    required String email,
    required String mobileno,
  }) async {
    String url = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/forgotpassword";
    var body = {
      "email": email.isEmpty ? null : email,
      "mobileno": mobileno.isEmpty ? null : mobileno,
    };
    final response = await _dio!.post(url, data: body);
    return response;
  }

  static Future<Response<dynamic>> resetPassword({
    String email = "",
    String mobileNo = "",
    required String otp,
    required String password,
  }) async {
    String url = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/forgotpassword";
    var body = {
      "email": email.isEmpty ? null : email,
      "otp": otp,
      "password": password,
    };

    if (mobileNo.isNotEmpty) {
      body["mobileno"] = mobileNo;
    }

    final response = await _dio!.put(url, data: body);
    return response;
  }

  static Future<ContentModel> getContent(
    String listtype, {
    String genre = "",
    String language = "",
    String objecttype = "",
    String subcategory = "",
    String tags = "",
    String category = "",
    String displaylanguage = "",
    String partnerid = "",
    int pagesize = 10,
    int page = 0,
  }) async {
    String url =
        "${AppUrls.baseUrlVCMS}/subscriber/v1/content?&orderby={%22updatedon%22%3A%22DSC%22%2C}&pagesize=$pagesize&page=$page";

    if (genre.isNotEmpty) {
      url =
          "$url&genre=$genre&subgenre=$genre&groupbyor=[%22genre%22%2C%22subgenre%22]";
    }
    if (partnerid.isNotEmpty) {
      url = "$url&partnerid=$partnerid";
    }
    if (listtype.isNotEmpty) {
      url = "$url&listtype=$listtype";
    }
    if (objecttype.isNotEmpty) {
      url = "$url&objecttype=$objecttype";
    }
    if (category.isNotEmpty) {
      url = "$url&category=$category";
    }

    if (subcategory.isNotEmpty) {
      url = "$url&subcategory=$subcategory";
    }
    if (tags.isNotEmpty) {
      url = "$url&tags=$tags";
    }
    if (displaylanguage.isNotEmpty) {
      url = "$url&displaylanguage=$displaylanguage";
    }
    if (language.isNotEmpty) {
      url = "$url&language=$language";
    }

    final response = await _dio!.get(url);
    ContentModel contentModel = ContentModel.fromMap(response.data);
    return contentModel;
  }

  static Future<ChaptersModel> getChapters(
      {required String seriesid, required String seasonnum}) async {
    String url =
        "${AppUrls.baseUrlVCMS}/subscriber/v1/content?objecttype=CONTENT&seasonnum=$seasonnum&seriesid=$seriesid";
    final response = await _dio!.get(url);
    ChaptersModel chaptersModel = ChaptersModel.fromMap(response.data);
    return chaptersModel;
  }

  static Future<ModulesModel> getModules({required String seriesid}) async {
    String url =
        "${AppUrls.baseUrlVCMS}/subscriber/v1/content?objecttype=SEASON&seriesid=$seriesid&PAGE=1";
    final response = await _dio!.get(url);
    ModulesModel modulesModel = ModulesModel.fromMap(response.data);
    return modulesModel;
  }

  static Future<ContentModel> getRelatedContent({
    required String contentid,
    String displaylanguage = "eng",
  }) async {
    String url =
        "${AppUrls.baseUrlVCMS}/subscriber/v1/content/related/$contentid?displaylanguage=$displaylanguage&PAGE=1";
    final response = await _dio!.get(url);
    ContentModel contentModel = ContentModel.fromMap(response.data);
    return contentModel;
  }

  static Future performSearch(String query) async {
    // String url =
    //     "${AppUrls.baseUrlVCMS}/subscriber/v1/content/search?query=$query";
    // final response = await _dio!.get(url);
    // ContentModel contentModel = ContentModel.fromMap(response.data);
    // return contentModel;
    // String url =
    //     "https://uz9jsl3qoc.execute-api.us-east-1.amazonaws.com/betav1/subscriber/v1/partners/completeSearch?searchtext=$query";
    // Dio dio = Dio();
    // dio.options.headers["X-SESSION"] =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWJzY3JpYmVyaWQiOiJ6ajU0RFZGSlk5eHQiLCJzdWJzY3JpYmVybmFtZSI6IkJoYXNrYXIiLCJlbWFpbCI6ImJoYXNrYXIucmVkZHlAbW9iaW90aWNzLmNvbSIsInByb2ZpbGVpZCI6InpqNTREVkZKWTl4dCIsImtpZHNtb2RlIjoiTk8iLCJob21lY291bnRyeSI6IklOIiwidmlzaXRpbmdjb3VudHJ5IjoiSU4iLCJkZXZpY2VpZGhhc2giOiI3MmM5MjU2ZWFlNjA0ODI1YmJhMGJmMDBmZDIwODEwMjg0YjE0OTk2IiwiZGV2aWNlaWQiOiI5NDkwNDEiLCJkZXZpY2V0eXBlIjoiUEMiLCJkZXZpY2VvcyI6IldFQk9TIiwiYXBwdmVyc2lvbiI6IjEuMC4wIiwib3N2ZXJzaW9uIjoiV2luMzIgMjY4MDk1IiwiaXAiOiIxMzAuMTc2LjE4NC42OSIsIkdlb0xvY0lwIjoiMTE1LjI0Mi4xMzUuMTYyIiwiaXNzdWVyIjoiZW5yaWNodHYiLCJleHBpcmVzSW4iOjMwMCwicHJvdmlkZXJuYW1lIjoiRW5yaWNoVHYiLCJpYXQiOjE2ODU2ODE2MTEsImV4cCI6MTY4NTY4MTkxMSwiaXNzIjoiZW5yaWNodHYifQ.cTPRkCI7EFBuQRyP6B4zJ6OO8kX3nAGz-U6ZOModEYQ";
    // final response = await dio.get(url);
    String url =
        "${AppUrls.baseUrlVAuth}/subscriber/v1/partners/completeSearch?searchtext=$query";
    final response = await _dio!.get(url);
    return response.data;
  }

  static Future<content.Datum> getContentDetail(String objectid) async {
    String url = "${AppUrls.baseUrlVCMS}/subscriber/v1/content/$objectid";
    final response = await _dio!.get(url);
    content.Datum datum = content.Datum.fromMap(response.data!);
    return datum;
  }

  static Future<PackageModel> getPackageDetail(content.Datum content) async {
    String objectId = content.objectid;
    Contentdetail detail = await PlayService().getPlatformMedia(content);
    var params = {
      'availabilityid': detail.availabilityset![0].toString(),
      'packageid': detail.packageid.toString(),
    };
    String url =
        "${AppUrls.baseUrlVCMS}/subscriber/v1/content/package/$objectId";

    final response = await _dio!.post(url, data: params);
    var data = response.data;
    return PackageModel.fromMap(data);
  }

  static Future<CategoryModel> getCategories() async {
    String url = "${AppUrls.baseUrlVCMS}/subscriber/v1/genre";
    final response = await _dio!.get(url);
    var data = response.data;
    Map<String, dynamic> categories = {};
    categories['categories'] = data;
    return CategoryModel.fromMap(categories);
  }

  //todo add to existing interceptor when backend team adds session token to the service
  static Future<CoachModel> getCoaches() async {
    String url = "${AppUrls.baseUrlVAuth}/subscriber/v1/partners?pagesize=100";
    final response = await _dio!.get(url);
    CoachModel coachModel = CoachModel.fromMap(response.data);
    return coachModel;
  }

  static Future<Datum> getCoach(String partnerid) async {
    String url =
        "${AppUrls.baseUrlVAuth}/subscriber/v1/partners?partnerid=$partnerid";
    final response = await _dio!.get(url);
    CoachModel coachModel = CoachModel.fromMap(response.data);
    return coachModel.data![0];
  }

  static Future<AvailabilityModel> fetchAvailability() async {
    String url = "${AppUrls.baseUrlVSMS}/subscriber/v1/availability";
    final response = await _dio!.get(url);
    var data = response.data;
    AvailabilityModel availabilityModel = AvailabilityModel.fromMap(data);
    return availabilityModel;
  }

  static getPurchaseList() async {
    String url = "${AppUrls.baseUrlVSMS}/subscriber/v1/purchase";
    final response = await _dio!.get(url);
    var data = response.data;
    return data;
  }

  static Future<Category> getCategory(String categoryid) async {
    String url = "${AppUrls.baseUrlVCMS}/subscriber/v1/genre/$categoryid";
    final response = await _dio!.get(url);
    var data = response.data;
    Category category = Category.fromMap(data);
    return category;
  }

  static Future<String> getSubcription() async {
    String endpoint = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/subscription";
    final response = await _dio!.get(endpoint);
    String data = jsonEncode(response.data);
    return data;
  }

  static Future<dynamic> getPriceClass(availabilityId) async {
    String endpoint =
        "${AppUrls.baseUrlVSMS}/subscriberv2/v1/availability/$availabilityId";
    final response = await _dio!.get(endpoint);
    return response.data;
  }

  static Future<dynamic> initializePayment(var params,
      {String gateway = "stripe"}) async {
    String url =
        "${AppUrls.baseUrlVCHARGE}/subscriber/v1/payment/init/$gateway";

    final response = await _dio!.post(url, data: params);
    var data = response.data;
    return data;
  }

  static Future<SubscriberModel> getSubscriber() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String url = "${AppUrls.baseUrlVSMS}/subscriber/v1/subscriber";
    final response = await _dio!.get(url);
    var data = response.data;
    if (response.statusCode == 200) {
      await sharedPreferences.setString(
          DeviceStorage.subscriberData, jsonEncode(data));
    }
    return SubscriberModel.fromMap(data);
  }

  static getInstructorEventDetails(String? instructorID) async {
    String endpoint =
        "${AppUrls.baseUrlVliveEvents}/subscriber/v1/getevent/?eventtype=SESSION&instructorid=$instructorID";
    final response = await _dio!.get(endpoint);
    return response.data;
  }

  static Future<EventsModel> getEvents({
    required bool isLoggedin,
    String instructorID = "",
    String category = "",
  }) async {
    String endpoint = "";
    String location = "";
    if (!isLoggedin) {
      location = "listevent";
    } else {
      location = "getevent";
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String now = formatter.format(DateTime.now());
    String base =
        "${AppUrls.baseUrlVliveEvents}/subscriber/v1/$location?eventtype=WEBINAR&startdate=$now";

    if (instructorID.isNotEmpty) {
      endpoint = "$base&instructorid=$instructorID";
    } else {
      endpoint = base;
    }
    if (category.isNotEmpty) {
      endpoint = "$endpoint&category=$category";
    }
    final response = await _dio!.get(endpoint);
    return EventsModel.fromMap(response.data);
  }

  static initializeSession(Map<String, String> params) async {
    String endpoint = "${AppUrls.baseUrlVliveEvents}/subscriber/v1/initsession";
    final response = await _dio!.post(endpoint, data: params);
    return response.data;
  }

  static Future<InstructorSessions> getSessions() async {
    String endpoint =
        "${AppUrls.baseUrlVliveEvents}/subscriber/v1/session?status=CONFIRMED";
    final response = await _dio!.get(endpoint);
    return InstructorSessions.fromMap(response.data);
  }

  static Future<ProfileModel> getProfile() async {
    String endpoint = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/profile";
    final response = await _dio!.get(endpoint);
    return ProfileModel.fromMap(response.data);
  }

  static saveProfile({
    required Map<String, String> payload,
  }) async {
    String endpoint = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/subscriber";
    final response = await _dio!.put(endpoint, data: payload);
    return response.data;
  }

  static uploadProfilePicture(FormData formdata) async {
    String endpoint = "${AppUrls.baseUrlVSMS}/image/v1/upload";
    final response = await _dio!.post(endpoint, data: formdata);
    return response.data;
  }

  static Future<PlansModel> getPlans() async {
    // SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    // String plansJson = sharedPreferences.getString(DeviceStorage.plans) ?? "";
    // if (plansJson.isNotEmpty) {
    //   var data = jsonDecode(plansJson);
    //   return PlansModel.fromMap(data);
    // }
    String endpoint = "${AppUrls.baseUrlVSMS}/subscriberv2/v1/plan";
    final response = await _dio!.get(endpoint);
    // await sharedPreferences.setString(
    //     DeviceStorage.plans, jsonEncode(response.data));
    return PlansModel.fromMap(response.data);
  }

  static sendDeleteAccountOtp() async {
    String endpoint =
        "${AppUrls.baseUrlVSMS}/subscriber/v1/subscriber/otp?otp_type=deleteAccount";
    final response = await _dio!.get(endpoint);
    return response.data;
  }

  static deleteAccount(String otp) async {
    String endpoint =
        "${AppUrls.baseUrlVSMS}/subscriberv2/v1/subscriber/delete";
    Map<String, String> params = {"otp": otp};
    final response = await _dio!.delete(endpoint, data: params);
    return response.data;
  }
}
