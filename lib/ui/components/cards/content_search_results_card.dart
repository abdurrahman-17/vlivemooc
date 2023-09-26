import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/content/content_model/datum.dart';

class ContentSearchResultsCard extends StatelessWidget {
  final Datum content;
  const ContentSearchResultsCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.semanticsMarginExSmall),
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () {
          RouteGenerator().navigate(context, RouteGenerator.generateContentRoute(content: content), extra: content);
          //   context.go(RouteGenerator.generateContentRoute(content: content),
         //     extra: content);
        },
        child: Card(
          elevation: Constants.cardElevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.cardBorderRadius)),
          child: Padding(
            padding: const EdgeInsets.all(Constants.semanticsMarginExSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 100,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: content.poster == null ||
                              content.poster![0].filelist == null
                          ? Container()
                          : Image.network(
                              content.poster![0].filelist![0].filename!),
                    )),
                const SizedBox(
                  width: Constants.semanticMarginDefault,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title!,
                      style: const TextStyle(
                          fontSize: Constants.fontSizeMedium,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: Constants.semanticsMarginExSmall,
                    ),
                    content.shortdescription != null
                        ? Text(
                            content.shortdescription!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: Constants.fontSizeSmall,
                            ),
                          )
                        : Container()
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
