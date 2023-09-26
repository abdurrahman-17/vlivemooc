import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';
import 'package:vlivemooc/ui/screens/auth/desktop_signup.dart';
import 'package:vlivemooc/ui/screens/auth/mobile_signup.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileView: MobileSignup(), desktopView: DesktopSignUp());
  }
}
