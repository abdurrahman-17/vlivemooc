import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class FacebookLogin {
  static initialize() async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
      // initialiaze the facebook javascript SDK
      await FacebookAuth.instance.webAndDesktopInitialize(
        appId: Constants.facebookAppId,
        cookie: true,
        xfbml: true,
        version: "v15.0",
      );
    }
  }
}
