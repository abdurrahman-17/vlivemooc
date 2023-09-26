import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/auth/login_component.dart';
import 'package:vlivemooc/ui/components/buttons/logo_button.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class MobileLogin extends StatelessWidget {
  const MobileLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: AppColors.primaryColor),
          width: double.infinity,
          height: double.infinity,
          //scrollview added to support pan when keyboard opens
          child: const Column(
            children: [
              Expanded(
                  flex: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to EnrichTV",
                        style: TextStyle(
                            fontSize: Constants.fontSizeLarge,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: Constants.semanticMarginDefault,
                      ),
                      LogoButton(assetURI: "assets/images/logo_white.png")
                    ],
                  )),
              Expanded(
                  flex: 15,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.defaultPagePaddingModile),
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(Constants.defaultPagePadding),
                          child: LoginComponent()),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
