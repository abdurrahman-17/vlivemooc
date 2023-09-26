import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar.dart';
import 'package:vlivemooc/ui/components/auth/create_account_component.dart';

import '../../constants/constants.dart';

class MobileCreateAccount extends StatelessWidget {
  const MobileCreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MobileAppBar(title: "Create Account"),
      body: Padding(
          padding: EdgeInsets.all(Constants.defaultPagePadding),
          child: CreateAccountComponent()),
    );
  }
}
