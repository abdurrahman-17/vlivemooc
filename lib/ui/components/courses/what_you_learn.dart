import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/content/content_model/datum.dart';

class WhatYouLarn extends StatelessWidget {
  final Datum content;
  const WhatYouLarn({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return content.whatwelearn == null
        ? Container()
        : SizedBox(
            child: Card(
              margin: EdgeInsets.zero,
              elevation: Constants.cardElevation,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Constants.cardBorderRadius)),
              child: Padding(
                padding: EdgeInsets.all(Constants.insetPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What you'll learn",
                      style: TextStyle(
                          fontSize: Constants.fontSizeMedium,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: content.whatwelearn.length,
                          itemBuilder: (BuildContext context, int index) {
                            String whatWeLearnText =
                                content.whatwelearn[index]['value'];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: Constants.semanticsMarginExSmall),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Icon(
                                      Icons.circle,
                                      color: AppColors.primaryColor,
                                      size: 10,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Constants.semanticsMarginExSmall,
                                  ),
                                  Expanded(
                                    child: Text(
                                      whatWeLearnText,
                                      style: const TextStyle(
                                          fontSize: Constants.fontSizeSmall),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
