import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/home/home_tabs.dart';

import '../../constants/colors.dart';
import '../appbar/mobile_top_bar.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MobileTopBar(
          logoPath: "assets/images/logo_white.png",
          backgroundColor: AppColors.primaryColor,
        ),
        const Expanded(child: HomeTabs())
      ],
    );
  }
}
