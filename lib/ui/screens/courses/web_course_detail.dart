import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/courses/course_title_layout.dart';
import 'package:vlivemooc/ui/components/courses/what_you_learn.dart';
import 'package:vlivemooc/ui/components/courses/course_content.dart';
import 'package:vlivemooc/ui/components/courses/course_description.dart';
import 'package:vlivemooc/ui/components/courses/course_image.dart';
import 'package:vlivemooc/ui/components/courses/course_includes.dart';
import 'package:vlivemooc/ui/components/courses/course_instructor.dart';
import 'package:vlivemooc/ui/components/courses/course_statistics.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';

import '../../../core/models/content/content_model/datum.dart';
import '../../components/appbar/top_bar.dart';
import '../../components/layout/content_layout.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../../core/models/coaches/coach_model/datum.dart' as coachclass;
import '../../routes/Routes.dart';

class WebCourseDetail extends StatefulWidget {
  final Datum content;
  final coachclass.Datum? coach;
  final String price;
  final String currency;
  const WebCourseDetail(
      {super.key,
      required this.content,
      required this.coach,
      required this.price,
      required this.currency});

  @override
  State<WebCourseDetail> createState() => _WebCourseDetailState();
}

class _WebCourseDetailState extends State<WebCourseDetail> {
  String moduleCount = "";
  String price = "";
  String totalEstimatedTime = "";
  String totalChapters = "";
  onMetaDataReceived(moduleCount_, totalChapters_, estimatedTime_) {
    setState(() {
      moduleCount = moduleCount_.toString();
      totalChapters = totalChapters_.toString();
      totalEstimatedTime = "${estimatedTime_.toInt()} Hour'(s)";
    });
  }

  @override
  void initState() {
    super.initState();
    price = "${widget.currency} ${widget.price}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: AppColors.accentColor,
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CourseTitleLayout(
                                content: widget.content,
                                isMobile: false,
                                coach: widget.coach,
                                modules: moduleCount,
                                price: price,
                              ),
                              const SizedBox(
                                height: 55,
                              ),
                              WhatYouLarn(content: widget.content),
                              SizedBox(
                                height: Constants.insetPadding,
                              ),
                              CourseContent(
                                content: widget.content,
                                onDataReceived: onMetaDataReceived,
                              ),
                              SizedBox(
                                height: Constants.insetPadding,
                              ),
                              CourseDescription(content: widget.content)
                            ],
                          )),

                      //required empty expanded for spacing
                      const Expanded(
                          flex: 1,
                          child: Column(
                            children: [],
                          )),

                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Constants.cardBorderRadius)),
                                elevation: Constants.cardElevation,
                                child: Column(
                                  children: [
                                    CourseImage(content: widget.content),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          Constants.insetPadding),
                                      child: CourseStatistics(
                                          moduleCount: moduleCount,
                                          estimatedTime: totalEstimatedTime,
                                          content: widget.content),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          Constants.insetPadding),
                                      child: CourseIncludes(
                                          chapterCount: totalChapters,
                                          content: widget.content),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Constants.insetPadding,
                              ),
                              CourseInstructor(coach: widget.coach),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Constants.semanticMarginDefault,
                ),
                ContentLayout(
                  renderEmpty: true,
                  title: "Related Courses",
                  listType: "",
                  objectType: "",
                  categoryType: '["COURSE"]',
                  related: widget.content.objectid,
                  showAll: AppRouter.courses,
                ),
                const SizedBox(
                  height: Constants.semanticMarginDefault,
                ),
                const WebFooter()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
