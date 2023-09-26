import 'package:flutter/material.dart';

import '../../../core/models/content/content_model/datum.dart';
import '../text/show_more_text.dart';

class CourseDescription extends StatelessWidget {
  final Datum content;
  const CourseDescription({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
   
    if (content.longdescription != null &&
        content.longdescription!.isNotEmpty) {
      return ShowMoreText(text: content.longdescription!);
    }
     if (content.shortdescription != null &&
        content.shortdescription!.isNotEmpty) {
      return ShowMoreText(text: content.shortdescription!);
    }

    return Container();
  }
}
