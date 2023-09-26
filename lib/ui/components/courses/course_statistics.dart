import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/helpers/language_codes.dart';
import '../../../core/models/content/content_model/datum.dart';

class CourseStatistics extends StatelessWidget {
  final Datum content;
  final String estimatedTime;
  final String moduleCount;
  const CourseStatistics(
      {super.key,
      required this.content,
      required this.estimatedTime,
      required this.moduleCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SKILL LEVEL",
              style: TextStyle(
                  fontSize: Constants.fontSizeMedium, color: Colors.grey),
            ),
            Text(
              content.skilllevel ?? "Beginner",
              style: const TextStyle(
                  fontSize: Constants.fontSizeSmall,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Constants.insetPadding,
            ),
            const Text(
              "Modules",
              style: TextStyle(
                  fontSize: Constants.fontSizeMedium, color: Colors.grey),
            ),
            Text(
              moduleCount,
              style: const TextStyle(
                  fontSize: Constants.fontSizeSmall,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ESTIMATED TIME",
              style: TextStyle(
                  fontSize: Constants.fontSizeMedium, color: Colors.grey),
            ),
            Text(
              estimatedTime,
              style: const TextStyle(
                  fontSize: Constants.fontSizeSmall,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Constants.insetPadding,
            ),
            const Text(
              "LANGUAGE",
              style: TextStyle(
                  fontSize: Constants.fontSizeMedium, color: Colors.grey),
            ),
            Text(
              content.contentlanguage != null
                  ? getLanguagesListFromAvailableLanguages(
                      content.contentlanguage!)
                  : "ENGLISH",
              style: const TextStyle(
                  fontSize: Constants.fontSizeSmall,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }
}
