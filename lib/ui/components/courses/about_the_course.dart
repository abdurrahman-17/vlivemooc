import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';

import '../../constants/constants.dart';

class AboutTheCourse extends StatelessWidget {
  final Datum content;
  const AboutTheCourse({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: Constants.cardElevation,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.cardBorderRadius))),
      child: Padding(
        padding: EdgeInsets.all(Constants.insetPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overview",
              style: TextStyle(
                  fontSize: Constants.fontSizeMedium,
                  fontWeight: FontWeight.bold),
            ),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: Constants.semanticMarginDefault,
            ),
            const Text(
              "About this course",
              style: TextStyle(
                fontSize: Constants.fontSizeMedium,
              ),
            ),
            Text(
              content.longdescription!,
              style: const TextStyle(fontSize: Constants.fontSizeSmall),
            ),
          ],
        ),
      ),
    );
  }
}
