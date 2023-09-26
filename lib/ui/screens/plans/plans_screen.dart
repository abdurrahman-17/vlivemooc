import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/cards/my_plans.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';

import '../../components/appbar/top_bar.dart';
import '../../constants/colors.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobileView: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
        ),
        body: const MyPlans(
          isMobile: true,
        ),
      )),
      desktopView: Scaffold(
        appBar: TopBar(
          logoPath: "assets/images/logo_white.png",
          backgroundColor: AppColors.primaryColor,
          renderNav: true,
        ),
        body: const MyPlans(
          isMobile: false,
        ),
      ),
    );
  }
}
