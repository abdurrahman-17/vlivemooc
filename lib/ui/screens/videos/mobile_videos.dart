import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar.dart';
import 'package:vlivemooc/ui/components/videos/videos.dart';

class MobileVideos extends StatelessWidget {
  const MobileVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
          appBar: MobileAppBar(
            title: "Videos",
          ),
          body: Videos()),
    );
  }
}
