import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/screens/courses/web_courses.dart';

import '../../responsive/responsive.dart';
import 'mobile_courses.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileView: MobileCourses(), desktopView: WebCourses());
  }
}
