import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';
import 'package:vlivemooc/ui/screens/auth/desktop_login.dart';
import 'package:vlivemooc/ui/screens/auth/mobile_login.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileView: MobileLogin(), desktopView: DesktopLogin());
  }
}
