import 'package:flutter/material.dart';

import '../../components/appbar/top_bar.dart';
import '../../components/coaches/coaches.dart';
import '../../constants/colors.dart';

class WebCoaches extends StatelessWidget {
  const WebCoaches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: const Coaches(
        isMobile: false,
      ),
    );
  }
}
