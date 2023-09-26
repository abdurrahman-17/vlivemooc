import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/image_filters.dart';
import 'package:vlivemooc/ui/components/buttons/play_floating_button.dart';
import '../../../core/models/content/content_model/datum.dart';
import '../../constants/constants.dart';

class CoursePlayback extends StatefulWidget {
  final Datum content;
  final Datum? chapter;
  const CoursePlayback(
      {super.key, required this.content, required this.chapter});
  @override
  State<CoursePlayback> createState() => _CoursePlaybackState();
}

class _CoursePlaybackState extends State<CoursePlayback> {
  getImageUrl(Datum content) {
    String imageUrl = "";
    try {
      imageUrl = getHdPosterLandscapeBasedOnGenre(content);
    } catch (err) {
      //do nothing here
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = getImageUrl(widget.content);

    if (widget.chapter != null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
              Radius.circular(Constants.cardBorderRadius)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: imageUrl.isEmpty
                    ? const Center(
                        child: Text(
                          "Poster not available",
                          style: TextStyle(fontSize: Constants.fontSizeMedium),
                        ),
                      )
                    : Image.network(imageUrl),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white.withOpacity(0.6),
                    padding:
                        const EdgeInsets.all(Constants.semanticMarginDefault),
                    child: Text(
                      widget.chapter!.title!,
                      style: const TextStyle(
                          fontSize: Constants.fontSizeMedium,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              PlayFloatingButton(content: widget.chapter!)
            ],
          ),
        ),
      );
    }
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(Constants.cardBorderRadius)),
        child: imageUrl.isEmpty
            ? const Center(
                child: Text(
                  "Poster not available",
                  style: TextStyle(fontSize: Constants.fontSizeMedium),
                ),
              )
            : Image.network(imageUrl),
      ),
    );
  }
}
