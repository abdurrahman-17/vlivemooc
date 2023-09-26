import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar.dart';

import '../../components/Courses/Courses.dart';

class MobileCourses extends StatelessWidget {
  const MobileCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
          appBar: MobileAppBar(
            title: "Courses",
          ),
          body: Courses()),
    );
  }
}
