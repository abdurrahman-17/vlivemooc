import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/content/content_model/datum.dart';

class CourseIncludes extends StatelessWidget {
  final Datum content;
  final String chapterCount;
  const CourseIncludes(
      {super.key, required this.content, required this.chapterCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "This course includes",
          style: TextStyle(
            fontSize: Constants.fontSizeMedium,
          ),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        Row(
          children: [
            Icon(
              Icons.play_circle,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: Constants.semanticsMarginExSmall,
            ),
            chapterCount.isEmpty
                ? Container()
                : Text(
                    "$chapterCount chapters",
                    style: const TextStyle(
                        fontSize: Constants.fontSizeSmall,
                        fontWeight: FontWeight.bold),
                  )
          ],
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        Row(
          children: [
            Icon(
              Icons.play_circle,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: Constants.semanticsMarginExSmall,
            ),
            const Text(
              "Full time access",
              style: TextStyle(
                  fontSize: Constants.fontSizeSmall,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}
