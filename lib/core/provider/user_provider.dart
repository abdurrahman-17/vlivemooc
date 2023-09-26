import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/models/subscriber/subscriber_model.dart';
import 'package:vlivemooc/core/storage/device_storage.dart';

import '../helpers/social_login_user.dart';

class UserProvider with ChangeNotifier {
  String signupPageForm = "";
  String signupCountryCode = "+91";
  bool signupPageIsEmail = true;
  bool isLoggedIn = false;
  String redirectLocation = "";
  String displayName = "";
  bool showLiveTv = false;
  SubscriberModel? subscriberModel;

  setRedirectLocation(location) {
    redirectLocation = location;
    notifyListeners();
  }

  updateSubscriber() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String data =
        sharedPreferences.getString(DeviceStorage.subscriberData) ?? "";
    if (data.isNotEmpty) {
      SubscriberModel model = SubscriberModel.fromMap(jsonDecode(data));
      subscriberModel = model;
      notifyListeners();
    }
  }

  updateLiveTvVisibility(bool show) {
    showLiveTv = show;
    notifyListeners();
  }

  static bool isInitialized = false;

  setIsLoggedIn(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }

  updateSignupPageForm(String text, bool isEmail,{String countryCode="+91"}) {
    signupPageForm = text;
    signupPageIsEmail = isEmail;
    signupCountryCode = countryCode;
    notifyListeners();
  }

  updateSocialUser(SocialLoginUser user) {
    signupPageForm = user.email;
    signupPageIsEmail = true;
    displayName = user.name;
    notifyListeners();
  }
}
