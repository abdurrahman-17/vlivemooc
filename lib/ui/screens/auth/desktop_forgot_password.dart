import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/animations/slide_transition_animation.dart';
import 'package:vlivemooc/ui/components/auth/forgot_password_component.dart';
import '../../components/appbar/top_bar.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class DesktopForgotPassword extends StatelessWidget {
  final bool isVerifyOtp;
  const DesktopForgotPassword({super.key,this.isVerifyOtp=false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          logoPath: "assets/images/logo_white.png",
          backgroundColor: AppColors.primaryColor),
      body:  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SlideTransitionAnimation(
            duration: const Duration(milliseconds: Constants.animationSnappy),
            child: SizedBox(
              width: Constants.webAuthCardWidth,
              height: 500,
              child: Card(
                  elevation: Constants.appBarElevation,
                  child: Padding(
                      padding: const EdgeInsets.all(Constants.defaultPagePadding),
                      child: ForgotPasswordComponent(isVerifyOtp:isVerifyOtp))),
            ),
          ),
        ),
      ),
    );
  }
}
