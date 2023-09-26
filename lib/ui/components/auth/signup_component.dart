import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/buttons/boxed_text_field.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';
import 'package:vlivemooc/ui/components/buttons/social_login.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

class SignupComponent extends StatefulWidget {
  const SignupComponent({super.key});

  @override
  State<SignupComponent> createState() => _SignupComponentState();
}

class _SignupComponentState extends State<SignupComponent> {
  bool isLoading = false;
  late TextEditingController emailPhoneController;
  bool isEmail = true;
  String error = "";
  String countryCode = "+91";

  @override
  initState() {
    super.initState();
    String value =
        Provider.of<UserProvider>(context, listen: false).signupPageForm;
    emailPhoneController = TextEditingController(text: value);

    emailPhoneController.addListener(() {
      if (error.isNotEmpty) {
        setState(() {
          error = "";
        });
      }
      String text = emailPhoneController.text;
      if (text.length < 6) {
        setState(() {
          isEmail = true;
        });
        return;
      }
      try {
        int.parse(text);
        setState(() {
          isEmail = false;
        });
      } catch (e) {
        setState(() {
          isEmail = true;
        });
      }
    });
  }

  onSubmit({required callback}) async {
    if (isLoading) {
      return;
    }
    String value = emailPhoneController.text;
    if (isEmail) {
      if (!Constants.emailReges.hasMatch(value)) {
        setState(() {
          error = "Please enter a valid Email and Mobile no";
        });
        return;
      }
    }
    String email = "";
    String phone = "";
    if (isEmail) {
      email = value;
    } else {
      phone = countryCode + value;
    }
    setState(() {
      isLoading = true;
    });
    var data = await NetworkHandler.verifyUser(email: email, phone: phone);
    setState(() {
      isLoading = false;
    });
    if (data.containsKey('errorcode')) {
      setState(() {
        error = data['reason'];
      });
    } else {
      bool isUser = data['success'];
      callback(isUser);
    }
  }

  parseResponse(BuildContext context, bool isUser) {
    String value = emailPhoneController.text;
    Provider.of<UserProvider>(context, listen: false)
        .updateSignupPageForm(value, isEmail,countryCode:countryCode);
    Map<String, dynamic> params = {'text': value, 'isEmail': isEmail};
    if (isUser) {
      RouteGenerator().navigate(context, AppRouter.login, extra: params);
     // context.go(AppRouter.login, extra: params);
    } else {
      RouteGenerator().navigate(context, AppRouter.createaccount, extra: params);

//      context.go(AppRouter.createaccount, extra: params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          BoxedTextField(
            icon: isEmail
                ? null
                : SizedBox(
                    width: 50,
                    child: CountryCodePicker(
                      padding: const EdgeInsets.all(2),
                      showFlagDialog: true,
                      searchDecoration: InputDecoration(
                          focusColor: AppColors.primaryColor,
                          fillColor: AppColors.primaryColor),
                      onChanged: (CountryCode code) {
                        setState(() {
                          countryCode = code.dialCode!;
                        });
                      },
                      initialSelection: countryCode,
                      textStyle: const TextStyle(color: Colors.black),
                      favorite: const ['+91', 'IN'],
                      showCountryOnly: true,
                      builder: (code) {
                        return Center(
                          child: Visibility(
                              visible: !isEmail, child: Text(code!.dialCode!)),
                        );
                      },
                      showOnlyCountryWhenClosed: true,
                      // optional. aligns the flag and the Text left
                      alignLeft: true,
                    ),
                  ),
            controller: emailPhoneController,
            keyboardType: TextInputType.emailAddress,
            autoFocus: true,
            textInputAction: TextInputAction.done,
            titleText: StringConstants.emailOrMobileNumber,
            onSubmitted: (value) {
              onSubmit(callback: (isUser) {
                parseResponse(context, isUser);
              });
            },
            errorText: error,
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          CircularLoadingElevatedButton(
            buttonText: "CONTINUE",
            onTap: () {
              onSubmit(callback: (isUser) {
                parseResponse(context, isUser);
              });
            },
            isLoading: isLoading,
          ),
          const SizedBox(
            height: Constants.regularMargin,
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
              : const SocialLogin(),
        ],
      ),
    );
  }
}
