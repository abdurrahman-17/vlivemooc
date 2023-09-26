import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/cards/instructor_course_card.dart';

import '../../../core/models/coaches/coach_model/datum.dart';

class CourseInstructor extends StatelessWidget {
  final Datum? coach;
  final bool isMobile;
  const CourseInstructor(
      {super.key, required this.coach, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    if (coach == null) {
      return Container();
    }
    return InstructorCourseCard(
      isMobile: isMobile,
      coach: coach!,
    );
  }
}
