import 'package:flutter/material.dart';

import '../../components/appbar/top_bar.dart';
import '../../components/courses/courses.dart';
import '../../constants/colors.dart';

class WebCourses extends StatelessWidget {
  const WebCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: const Courses(isMobile: false),
    );
  }
}
