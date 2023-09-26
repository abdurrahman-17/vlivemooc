import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';
import '../../routes/Routes.dart';
import '../buttons/boxed_text_field.dart';
import '../buttons/email_disabled_text_field.dart';
import 'otp_component.dart';

class ForgotPasswordComponent extends StatefulWidget {
  final bool isVerifyOtp;

  const ForgotPasswordComponent({super.key, this.isVerifyOtp = false});

  @override
  State<ForgotPasswordComponent> createState() =>
      _ForgotPasswordComponentState();
}

class _ForgotPasswordComponentState extends State<ForgotPasswordComponent> {
  bool isLoading = false;
  String error = "";
  bool emailVerification = false;

  TextEditingController newPassword = TextEditingController();
  String updatePasswordError = "";

  @override
  initState() {
    super.initState();
  }

  onResetPassword({required callback}) async {
    if (isLoading) {
      return;
    }

    //Check entered passwords are same.
    if (otp.isEmpty || otp.length < Constants.otpLength) {
      setState(() {
        invalidOtpMsg = "Please enter valid Otp";
      });
      return;
    }
    //Check entered passwords are same.
    if (newPassword.text.isEmpty) {
      setState(() {
        updatePasswordError = "Please enter your new password";
      });
      return;
    }
    if (newPassword.text.length < Constants.otpLength) {
      setState(() {
        updatePasswordError = "Password length is small";
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = true;
    });
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String email = userProvider.signupPageForm;
    bool isEmail = userProvider.signupPageIsEmail;
    try {
      Response<dynamic> response = await NetworkHandler.resetPassword(
          email: isEmail ? email : "",
          mobileNo: isEmail ? "" : (userProvider.signupCountryCode + email),
          otp: otp,
          password: newPassword.text);
      callback(response);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("An Unknown error occurred. Please try again")));
    }

    setState(() {
      isLoading = false;
    });
  }

  onVerifyAccount({required callback}) async {
    if (isLoading) {
      return;
    }

    //Check entered passwords are same.
    if (otp.isEmpty || otp.length < Constants.otpLength) {
      setState(() {
        invalidOtpMsg = "Please enter valid Otp";
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String mobile =
        userProvider.signupCountryCode + userProvider.signupPageForm;
    try {
      Response<dynamic> response = await NetworkHandler.confirmEmailOrMobile(
        mobileno: mobile,
        otp: otp,
      );
      callback(response);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("An Unknown error occurred. Please try again")));
    }

    setState(() {
      isLoading = false;
    });
  }

  resendEmail() {
    String value =
        Provider.of<UserProvider>(context, listen: false).signupPageForm;
    bool isEmail =
        Provider.of<UserProvider>(context, listen: false).signupPageIsEmail;

    setState(() {
      emailVerification = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isEmail
            ?"A verification link has been sent to your email": "Otp sent to your Mobile number"
            )));
    NetworkHandler.resendEmailOrPhoneVerification(
        email: isEmail ? value : "", phone: isEmail ? "" : value);
  }

  parseResponse(BuildContext context, Response response) {
    if (response.statusCode == 200) {
      context.go(AppRouter.signup);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(widget.isVerifyOtp
              ? StringConstants.mobileVerifiedSuccessFully
              : StringConstants.passwordResetSuccessfully)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.data["reason"] ?? "")));
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    bool isEmail = userProvider.signupPageIsEmail;
    String headerText = widget.isVerifyOtp
        ? StringConstants.verifyMobileNumber
        : (isEmail
            ? StringConstants.enterOtpEmail
            : StringConstants.enterOtpMobile);
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            headerText,
            style: poppinsMedium(22, AppColors.blackcolor),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          EmailDisabledTextField(
              titleText: StringConstants.emailOrMobileNumber),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          OtpComponent(
              onOtpEntered: onOtpEntered,
              invalidOtpMsg: invalidOtpMsg,
              isVerifyOtp: widget.isVerifyOtp),
          widget.isVerifyOtp
              ? Container()
              : Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: BoxedTextField(
                    controller: newPassword,
                    titleText: "New Password",
                    errorText: updatePasswordError,
                    obscureText: true,
                  )),
          SizedBox(
            height: widget.isVerifyOtp
                ? Constants.zeroPadding
                : Constants.semanticMarginDefault,
          ),
          CircularLoadingElevatedButton(
            buttonText: widget.isVerifyOtp ? "Verify" : "RESET PASSWORD",
            onTap: () {
              if (widget.isVerifyOtp) {
                onVerifyAccount(callback: (response) {
                  parseResponse(context, response);
                });
              } else {
                onResetPassword(callback: (response) {
                  parseResponse(context, response);
                });
              }
            },
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }

  String otp = "";
  String invalidOtpMsg = "";

  onOtpEntered(String otpEntered) {
    setState(() {
      otp = otpEntered;
      invalidOtpMsg = "";
    });
  }
}
