import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/screens/auth/desktop_forgot_password.dart';
import 'package:vlivemooc/ui/screens/auth/mobile_forgot_password.dart';

import '../../responsive/responsive.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return   const Responsive(
        mobileView: MobileForgotPassword(), desktopView: DesktopForgotPassword());
  }
}
