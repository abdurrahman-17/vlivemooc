import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/animations/slide_transition_animation.dart';
import '../../components/appbar/top_bar.dart';
import '../../components/auth/create_account_component.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class DesktopCreateAccount extends StatelessWidget {
  const DesktopCreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopBar(
          logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,renderNav: true,),
      body:  const SizedBox(
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: SlideTransitionAnimation(
              duration: Duration(milliseconds: Constants.animationSnappy),
              child: SizedBox(
                width: Constants.webAuthCardWidth,
                child: Card(
                  elevation: Constants.appBarElevation,
                  child: Padding(
                    padding: EdgeInsets.all(Constants.defaultPagePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: Constants.fontSizeLarge,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Constants.semanticMarginDefault,
                        ),
                        CreateAccountComponent(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
