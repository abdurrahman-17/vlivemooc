import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../../core/fireabse/firebase_actions.dart';
import '../../../core/fireabse/firecontent_service.dart';
import '../../../core/helpers/image_filters.dart';
import '../../../core/helpers/text_styles.dart';
import '../../constants/colors.dart';

class MyCourseLearningCard extends StatefulWidget {
  final FireDatum fireContent;
  final bool isMobile;

  const MyCourseLearningCard(
      {super.key, required this.fireContent, required this.isMobile});

  @override
  State<MyCourseLearningCard> createState() => _MyCourseLearningCardState();
}

class _MyCourseLearningCardState extends State<MyCourseLearningCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthOfImage = widget.isMobile ? (0.4 * screenWidth) : 200;
    return Card(
      elevation: 1,
      color: widget.isMobile ? Colors.white : AppColors.greyColor8,
      child: InkWell(
        onTap: () {
          //THis is to show progress bar and perform click functionality
          fireContentService.showProgressBarAfterFireContentClick(widget.fireContent, context, (){context.pop();} );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
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
                        ],
                      ))),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widget.isMobile ? screenWidth*0.43 : 300,
                      child: Text(widget.fireContent.title,
                          overflow: TextOverflow.ellipsis,
                          style:
                          poppinsBold(widget.isMobile ? 14 : 16, AppColors.violettextcolor)
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Speaker : ${widget.fireContent.objectowner ?? ""}",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.violettextcolor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins-Regular",
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 6,
                      width: widthOfImage,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        child: LinearProgressIndicator(
                          value: (firebaseActions.getWatchedPercentage(widget.fireContent) ),
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
                      "${widget.fireContent.objecttype == StringConstants.series ? (widget.fireContent.category==StringConstants.course? "Course":"Series") : "Video"} |  ${(firebaseActions.getWatchedPercentage(widget.fireContent)*100).round()}% Complete",
                      style: TextStyle(
                          fontSize: widget.isMobile ? 11 : 12,
                          fontFamily: "Inter-SemiBold",
                          color: AppColors.greytextcolor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
