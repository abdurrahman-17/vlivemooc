import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/helpers/play_state.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../../core/fireabse/firecontent_service.dart';
import '../../../core/helpers/app_screen_dimen.dart';
import '../../../core/helpers/image_filters.dart';
import '../../constants/constants.dart';



class ContinueLearningCard extends StatefulWidget {
  final FireDatum fireContent;
  const ContinueLearningCard({super.key,required this.fireContent});

  @override
  State<ContinueLearningCard> createState() => _ContinueLearningCardState();
}

class _ContinueLearningCardState extends State<ContinueLearningCard> {

  PlayState playState= PlayState(buttonState: " ", isLoading: false);
  @override
  Widget build(BuildContext context) {
    return getCard(isMobile(context));
  }


  Widget getCard(bool isMobile) {
    return InkWell(
      onTap: () {
        //Navigate to Player Directly
        fireContentService.showProgressBarAfterFireContentClick(widget.fireContent, context, (){context.pop();} );

      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width:isMobile?  230:MediaQuery.of(context).size.width / 4.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16/9,
                child: ClipRRect(
                    borderRadius:const BorderRadius.only(
                        topRight: Radius.circular(9),
                        topLeft: Radius.circular(9)),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CachedNetworkImage(
                           imageUrl: getPosterFromFireContent(widget.fireContent),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child:  Text(
                        widget.fireContent.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.fontSizeMedium),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              SizedBox(
                                height: 6,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                  child: LinearProgressIndicator(
                                    value: firebaseActions.getWatchedPercentage(widget.fireContent) ,
                                    backgroundColor: AppColors.greyColor3,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(AppColors.buttonTextBlue),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                "${widget.fireContent.objecttype == StringConstants.series ? "Course" : "Video"} |  ${(firebaseActions.getWatchedPercentage(widget.fireContent)*100).round()}% Complete",
                                style: TextStyle(
                                    fontSize: isMobile ? 13 : 16,
                                    fontFamily: "Inter-SemiBold",
                                    color: AppColors.greytextcolor),
                              )
                            ],
                          ),
                        )



                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
