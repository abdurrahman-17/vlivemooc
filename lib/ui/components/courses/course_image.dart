import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/image_filters.dart';

import '../../../core/models/content/content_model/datum.dart';
import '../../constants/constants.dart';
import '../buttons/play_floating_button.dart';

class CourseImage extends StatelessWidget {
  final Datum content;
  const CourseImage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    try {
      imageUrl = getHdPosterLandscapeBasedOnGenre(content);
    } catch (err) {
      //do nithing here
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
                Radius.circular(Constants.cardBorderRadius)),
            child: imageUrl.isEmpty
                ? const Center(
                    child: Text(
                      "Poster not available",
                      style: TextStyle(fontSize: Constants.fontSizeMedium),
                    ),
                  )
                : Image.network(imageUrl),
          ),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: PlayFloatingButton(
            content: content,
            isCourse: true,
          ),
        )
      ],
    );
  }
}
