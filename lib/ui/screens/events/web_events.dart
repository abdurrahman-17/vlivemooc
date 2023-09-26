import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/Events/Events.dart';

import '../../components/appbar/top_bar.dart';
import '../../constants/colors.dart';

class WebEvents extends StatelessWidget {
  const WebEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: const Events(isMobile: false),
    );
  }
}
