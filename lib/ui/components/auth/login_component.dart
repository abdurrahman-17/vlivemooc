import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/buttons/boxed_text_field.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';
import 'package:vlivemooc/ui/components/buttons/signup_disabled_text_field.dart';
import 'package:vlivemooc/ui/components/buttons/social_login.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../routes/Routes.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({super.key});

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  bool isLoading = false;
  TextEditingController passwordController = TextEditingController();
  String error = "";
  bool emailVerification = false;
  bool isEmail = false;

  @override
  initState() {
    super.initState();
    UserProvider userProvider= Provider.of<UserProvider>(context, listen: false);
    isEmail=userProvider.signupPageIsEmail;
    passwordController.addListener(() {
      if (error.isNotEmpty) {
        setState(() {
          error = "";
        });
      }
    });
  }

  onSubmit({required callback}) async {
    if (isLoading) {
      return;
    }

    String value = passwordController.text;
    if (value.isEmpty) {
      setState(() {
        error = "Password is required";
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

   UserProvider userProvider= Provider.of<UserProvider>(context, listen: false);
    String email =
        userProvider.signupPageForm;

    String emailID = "";
    String phone = "";
    if (isEmail) {
      emailID = email;
    } else {
      phone = userProvider.signupCountryCode+email;
    }

    Map<String, dynamic> response =
        await NetworkHandler.login(email: emailID, mobileno: phone, password: value);

    if (response['status']) {
      try {
        await NetworkHandler.getSubscriber();
      } catch (error) {
        //TO DO log the error here, this should not fail
      }
    }
    setState(() {
      isLoading = false;
    });
    callback(response);
  }

  onForgotPassword({required callback}) async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    UserProvider userProvider= Provider.of<UserProvider>(context, listen: false);
    String email =
        userProvider.signupPageForm;

    String emailID = "";
    String phone = "";
    if (isEmail) {
      emailID = email;
    } else {
      phone = userProvider.signupCountryCode+email;
    }

    Response<dynamic> response =
        await NetworkHandler.forgotPassword(email: emailID,mobileno:phone);
    setState(() {
      isLoading = false;
    });
    callback(response);

  }

  resendEmail() {

    UserProvider userProvider= Provider.of<UserProvider>(context, listen: false);

    String value =
        userProvider.signupPageForm;

    setState(() {
      emailVerification = false;
    });
    if(isEmail)
   {
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text("A verification link has been sent to your email")));

   }
    NetworkHandler.resendEmailOrPhoneVerification(
        email: isEmail ? value : "", phone: isEmail ? "" : userProvider.signupCountryCode+value);
    if(!isEmail){
      RouteGenerator().navigate(context, AppRouter.verifyAccount);
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
         // RouteGenerator().navigate(context, location);
         context.go(location);
      } else {
         context.go(AppRouter.home);
        //RouteGenerator().navigate(context, AppRouter.home);
      }
    } else {
      if (response['data']['reason'] == "Email Verification Pending") {
        setState(() {
          emailVerification = true;
          isLoading = false;

        });
      } else {
        //show verification email popup
        setState(() {
          isLoading = false;
          emailVerification=false;
          error = response['data']['reason'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SignupDisabledTextField(),
          emailVerification
              ? Row(
                  children: [
                     Expanded(
                        child: Text(
                          isEmail? "Email verification pending":"Mobile verification pending",
                      style: const TextStyle(color: Colors.red),
                    )),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.primaryColor),
                        onPressed: () {
                          resendEmail();
                        },
                        child: const Text("Resend"))
                  ],
                )
              : Container(),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          BoxedTextField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            autoFocus: true,
            textInputAction: TextInputAction.done,
            titleText: "Password",
            onSubmitted: (value) {
              onSubmit(callback: (response) {
                parseResponse(context, response);
              });
            },
            errorText: error,
          ),
          const SizedBox(
            height: Constants.semanticMarginTen,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {onForgotPassword(callback: onForgotPasswordSuccessful);},
                child: Text(
                  "Forgot Password?",
                  style: poppinsMedium(13, AppColors.primaryColor),
                ),
              )),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          CircularLoadingElevatedButton(
            buttonText: "LOGIN",
            onTap: () {
              onSubmit(callback: (response) {
                parseResponse(context, response);
              });
            },
            isLoading: isLoading,
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          (defaultTargetPlatform == TargetPlatform.android &&
                  getScreenWidth(context) > 600)
              ? Container()
              : const Text(
                  "or continue with",
                  style: TextStyle(fontSize: Constants.fontSizeSmall),
                ),
          (defaultTargetPlatform == TargetPlatform.android &&
                  getScreenWidth(context) > 600)
              ? Container()
              : const SizedBox(
                  height: Constants.semanticMarginDefault,
                ),
          (defaultTargetPlatform == TargetPlatform.android &&
                  getScreenWidth(context) > 600)
              ? Container()
              : const SocialLogin()
        ],
      ),
    );
  }

  onForgotPasswordSuccessful(Response<dynamic> response) {
    if (response.statusCode== 200) {
      RouteGenerator().navigate(context, AppRouter.forgotPassword);
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(isEmail? StringConstants.otpSentSuccessfully:StringConstants.otpSentSuccessfully)));
    }else{

      Map<String,dynamic> errorResponse =response.data;

      if (errorResponse['errorcode'] == 6110) {
        setState(() {
          emailVerification = true;
          isLoading = false;
        });
      } else {
        //show verification email popup
        setState(() {
          isLoading = false;
          emailVerification=false;
          error = errorResponse['reason'];
        });
      }

    }
  }
}
