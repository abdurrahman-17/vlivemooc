import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/screens/coaches/web_coaches.dart';

import '../../responsive/responsive.dart';
import 'mobile_coaches.dart';

class CoachesScreen extends StatelessWidget {
  const CoachesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileView: MobileCoaches(), desktopView: WebCoaches());
  }
}
