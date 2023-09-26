import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/live/live_tv.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/components/home/home.dart';

import '../../constants/colors.dart';

class WebHome extends StatelessWidget {
  const WebHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool showLiveTv =
          Provider.of<UserProvider>(context, listen: false).showLiveTv;
      if (showLiveTv) {
        LiveTV().play(context);
        Provider.of<UserProvider>(context, listen: false)
            .updateLiveTvVisibility(false);
      }
    });
    return Scaffold(
        appBar: TopBar(
          logoPath: "assets/images/logo_white.png",
          backgroundColor: AppColors.primaryColor,
          renderNav: true,
        ),
        body: Home());
  }
}
