import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/videos/videos.dart';

import '../../components/appbar/top_bar.dart';
import '../../constants/colors.dart';

class WebVideos extends StatelessWidget {
  const WebVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: const Videos(
        isMobile: false,
      ),
    );
  }
}
