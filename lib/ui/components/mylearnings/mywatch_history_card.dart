import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/helpers/time_calculator.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../../core/fireabse/firecontent_service.dart';
import '../../../core/helpers/image_filters.dart';
import '../../../core/helpers/text_styles.dart';
import '../../constants/colors.dart';

class MyWatchHistoryCard extends StatefulWidget {
  final FireDatum fireContent;
  final bool isMobile;
  final bool isWatchHistory;

  const MyWatchHistoryCard(
      {super.key,
      required this.fireContent,
      required this.isMobile,
      required this.isWatchHistory});

  @override
  State<MyWatchHistoryCard> createState() => _MyWatchHistoryCardState();
}

class _MyWatchHistoryCardState extends State<MyWatchHistoryCard> {

  @override
  Widget build(BuildContext context) {
    return getCard();
  }


  Widget getCard() {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthOfImage = widget.isMobile ? (0.4 * screenWidth) : 200;

    return Card(
      elevation: 1,
      color: widget.isMobile ? Colors.white : AppColors.greyColor8,
      child: InkWell(
        onTap: ()  {
          fireContentService.showProgressBarAfterFireContentClick(widget.fireContent,context,(){context.pop();});
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: getLandscapeImageHeight(widthOfImage),
                      width: widthOfImage,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: getLandscapeImageHeight(widthOfImage),
                                child: Image.network(
                                  getPosterFromFireContent(widget.fireContent),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: -1,
                                child: SizedBox(
                                  height: 6,
                                  width: widthOfImage,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    child: LinearProgressIndicator(
                                      value: firebaseActions.getWatchedPercentage(widget.fireContent),
                                      backgroundColor: AppColors.greyColor3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.buttonTextBlue),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widget.isMobile ? screenWidth * 0.43 : 300,
                          child: Text(widget.fireContent.title,
                              overflow: TextOverflow.ellipsis,
                              style: poppinsBold(widget.isMobile ? 14 : 16,
                                  AppColors.violettextcolor)),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text("Speaker : ${widget.fireContent.objectowner ?? ""}",
                            style: poppinsMedium(widget.isMobile ? 12 : 14,
                                AppColors.violettextcolor)),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                            widget.fireContent.objecttype ==
                                StringConstants.series
                                ? "Contains Episodes"
                                : ("Duration: ${TimeCalculator().formatTimetoMinsFromSec(timeInSecond: widget.fireContent.duration)}Min"),
                            style: poppinsMedium(widget.isMobile ? 11 : 13,
                                AppColors.textLight1)),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  right: 1,
                  top: 20,
                  child: Tooltip(
                    message: widget.isWatchHistory
                        ? 'Remove from Watch history'
                        : "Remove from Watchlist",
                    child: InkWell(
                      onTap: () {
                        if (widget.isWatchHistory) {
                          firebaseActions
                              .removeNode(widget.fireContent.objectid);
                        } else {
                          //Remove from watchList
                          firebaseActions.removeFromWatchList(
                              fireContentValue: widget.fireContent);
                        }
                      },
                      child: CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.white,
                        child: Icon(
                          widget.isWatchHistory
                              ? Icons.cancel_outlined
                              : Icons.bookmark_remove_outlined,
                          color: AppColors.textLight1,
                          size: widget.isMobile ? 20 : 25,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
