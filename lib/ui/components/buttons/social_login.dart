// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';
import 'package:vlivemooc/ui/components/dialogs/pogress_dialog.dart';
import '../../../core/helpers/social_login_user.dart';
import '../../../core/network/network_handler.dart';
import '../../../core/provider/user_provider.dart';
import '../../constants/constants.dart';
import '../../routes/Routes.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  late GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(
      clientId: ProviderConstants.googleSigninClientId,
      scopes: [
        'email',
      ],
    );
  }

  fbIfUserIsLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      if (kDebugMode) {
        print("User data ");
        print(userData.toString());
        print("Accesstoken ");
        print(accessToken.token);
      }

      handleSocialLogin(userData['name'], userData['email'],
          userData['picture']['data']['url'],
          fbToken: accessToken.token);
    } else {
      fbLogin();
    }
  }

  fbLogin() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      String? accessToken = loginResult.accessToken?.token;

      final userData = await FacebookAuth.instance.getUserData();
      handleSocialLogin(userData['name'], userData['email'],
          userData['picture']['data']['url'],
          fbToken: accessToken);
    } else {
      if (kDebugMode) {
        print('ResultStatus: ${loginResult.status}');
        print('Message: ${loginResult.message}');
      }
    }
  }

  _handleLogin(
    Function onComplete,
    SocialLoginUser user, {
    String gtoken = "",
    String fbToken = "",
    String appleToken = "",
  }) async {
    Map<String, dynamic> response = await NetworkHandler.login(
        gToken: gtoken, fbToken: fbToken, appleToken: appleToken);
    if (response['data'].containsKey('errorcode')) {
      if (response['data']['errorcode'] == 6001 &&
          response['data']['reason'] == "Invalid User") {
        onComplete(response, true);
        return;
      }
      _somethingWentWrong();
      return;
    }

    if (response['status']) {
      try {
        await NetworkHandler.getSubscriber();
      } catch (error) {
        //Todo: log the error here, this should not fail
      }
      onComplete(response, false);
    }
  }

  parseResponse(BuildContext context, response) {
    if (response['status']) {
      Provider.of<UserProvider>(context, listen: false).setIsLoggedIn(true);

      Provider.of<UserProvider>(context, listen: false).updateSubscriber();
      if (GoRouter.of(context).canPop()) {
        context.pop();
      }
      String location =
          Provider.of<UserProvider>(context, listen: false).redirectLocation;
      if (location.isNotEmpty) {
        context.go(location);
      } else {
        context.go(AppRouter.home);
      }
    } else {
      _somethingWentWrong();
    }
  }

  _somethingWentWrong() {
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Oops, something went wrong, please try again later")));
  }

  _parseGoogleResponse(
      GoogleSignInAccount result, GoogleSignInAuthentication googleKey) {
    handleSocialLogin(
        result.displayName ?? "", result.email, result.photoUrl ?? "",
        gtoken: googleKey.idToken!);
  }

  _signinGoogleCallback(GoogleSignInAccount? result) {
    result?.authentication.then((googleKey) {
      // print(googleKey.accessToken);
      // print(googleKey.idToken);
      // print(_googleSignIn.currentUser?.displayName);
      _parseGoogleResponse(result, googleKey);
    }).catchError(_signInError);
  }

  _signInError(err) {
    _somethingWentWrong();
  }

  _signinWithGoogle() {
    showProgressDialog(context);
    if (kIsWeb) {
      _googleSignIn
          .signInSilently()
          .then(_signinGoogleCallback)
          .catchError(_signInError);
    } else {
      _googleSignIn
          .signIn()
          .then(_signinGoogleCallback)
          .catchError(_signInError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: Constants.buttonHeight,
            height: Constants.buttonHeight,
            child: IconButton(
                onPressed: () {
                  _signinWithGoogle();
                },
                icon: Image.asset("assets/images/google_logo.png"))),
        const SizedBox(
          width: Constants.semanticsMarginExSmall,
        ),
        SizedBox(
            width: Constants.buttonHeight,
            height: Constants.buttonHeight,
            child: IconButton(
                onPressed: () {
                  fbIfUserIsLoggedIn();
                },
                icon: Image.asset("assets/images/facebook_logo.png"))),
        /*  const SizedBox(
          width: Constants.semanticsMarginExSmall,
        ),
        SizedBox(
            width: Constants.buttonHeight,
            height: Constants.buttonHeight,
            child: IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/apple_logo.png")))*/
      ],
    );
  }

  void handleSocialLogin(String displayName, String email, String? photoUrl,
      {String? gtoken, String? fbToken}) {
    SocialLoginUser user = SocialLoginUser(
        name: displayName, email: email, photoUrl: photoUrl ?? "");

    showProgressDialog(context);
    _handleLogin((response, isNewUser) async {
      context.pop();
      if (isNewUser) {
        // Provider.of<UserProvider>(context, listen: false)
        //     .updateSocialUser(user);
        // context.pop();
        // Map<String, dynamic> params = {'text': user.email, 'isEmail': true};
        // context.go(AppRouter.createaccount, extra: params);
        await NetworkHandler.createAccount(fbtoken: fbToken, gtoken: gtoken);
        handleSocialLogin(displayName, email, photoUrl,
            gtoken: gtoken, fbToken: fbToken);
      } else {
        parseResponse(context, response);
      }
    }, user, gtoken: gtoken ?? "", fbToken: fbToken ?? "");
  }
}
