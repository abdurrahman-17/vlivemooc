import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';
import 'package:vlivemooc/ui/screens/auth/mobile_create_account.dart';

import 'desktop_create_account.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileView: MobileCreateAccount(), desktopView: DesktopCreateAccount());
  }
}
