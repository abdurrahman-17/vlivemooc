import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/screens/videos/mobile_videos.dart';
import 'package:vlivemooc/ui/screens/videos/web_videos.dart';

import '../../responsive/responsive.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileView: MobileVideos(), desktopView: WebVideos());
  }
}
