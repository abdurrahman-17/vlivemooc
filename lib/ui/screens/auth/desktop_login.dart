import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/animations/slide_transition_animation.dart';
import 'package:vlivemooc/ui/components/auth/login_component.dart';
import '../../components/appbar/top_bar.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class DesktopLogin extends StatelessWidget {
  const DesktopLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,renderNav: true,),
      body: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SlideTransitionAnimation(
            duration: Duration(milliseconds: Constants.animationSnappy),
            child: SizedBox(
              width: Constants.webAuthCardWidth,
              height: 470,
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
                            LoginComponent()
                          ]))),
            ),
          ),
        ),
      ),
    );
  }
}
