import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/animations/slide_transition_animation.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/components/auth/signup_component.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';

class DesktopSignUp extends StatelessWidget {
  const DesktopSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,renderNav: true,),
      body: const SizedBox(
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: SlideTransitionAnimation(
              duration: Duration(milliseconds: Constants.animationSnappy),
              child: SizedBox(
                width: Constants.webAuthCardWidth,
                height: 390,
                child: Card(
                    elevation: Constants.appBarElevation,
                    child: Padding(
                        padding: EdgeInsets.all(Constants.defaultPagePadding),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome to EnrichTV",
                                style: TextStyle(
                                    fontSize: Constants.fontSizeLarge,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Constants.semanticMarginDefault,
                              ),
                              SignupComponent()
                            ]))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
