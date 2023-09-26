import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar.dart';
import 'package:vlivemooc/ui/components/auth/forgot_password_component.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

class MobileForgotPassword extends StatelessWidget {
  final bool isVerifyOtp;

  const MobileForgotPassword({super.key, this.isVerifyOtp = false});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        appBar:  MobileAppBar(
          title: isVerifyOtp? "": StringConstants.forgotPassword,
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.marginThirty,
                  vertical: Constants.semanticsMarginExSmall),
              child: ForgotPasswordComponent(isVerifyOtp:isVerifyOtp)),
        ),
      ),
    );
  }
}
