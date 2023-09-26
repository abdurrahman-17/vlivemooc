import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/courses/course_title_layout.dart';
import 'package:vlivemooc/ui/components/courses/what_you_learn.dart';
import 'package:vlivemooc/ui/components/courses/course_content.dart';
import 'package:vlivemooc/ui/components/courses/course_description.dart';
import 'package:vlivemooc/ui/components/courses/course_image.dart';
import 'package:vlivemooc/ui/components/courses/course_includes.dart';
import 'package:vlivemooc/ui/components/courses/course_instructor.dart';
import 'package:vlivemooc/ui/components/courses/course_statistics.dart';

import '../../../core/models/content/content_model/datum.dart';
import '../../../core/models/coaches/coach_model/datum.dart' as coachclass;
import '../../components/appbar/mobile_app_bar.dart';
import '../../components/layout/content_layout.dart';
import '../../routes/Routes.dart';

class MobileCourseDetail extends StatefulWidget {
  final Datum content;
  final coachclass.Datum? coach;
  final String price;
  final String currency;
  const MobileCourseDetail(
      {super.key,
      required this.content,
      required this.coach,
      required this.price,
      required this.currency});

  @override
  State<MobileCourseDetail> createState() => _MobileCourseDetailState();
}

class _MobileCourseDetailState extends State<MobileCourseDetail> {
  String moduleCount = "";
  String price = "";
  String totalEstimatedTime = "";
  String totalChapters = "";

  @override
  void initState() {
    super.initState();
    price = "${widget.currency} ${widget.price}";
  }

  onMetaDataReceived(moduleCount_, totalChapters_, estimatedTime_) {
    setState(() {
      moduleCount = moduleCount_.toString();
      totalChapters = totalChapters_.toString();
      totalEstimatedTime = "${estimatedTime_.toInt()} Hour'(s)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
          appBar: MobileAppBar(
            title: widget.content.title!,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CourseImage(content: widget.content),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: CourseTitleLayout(
                      content: widget.content,
                      coach: widget.coach,
                      modules: moduleCount,
                      price: price,
                    )),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: CourseStatistics(
                        moduleCount: moduleCount,
                        estimatedTime: totalEstimatedTime,
                        content: widget.content)),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: WhatYouLarn(content: widget.content)),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: CourseContent(
                      content: widget.content,
                      onDataReceived: onMetaDataReceived,
                    )),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: CourseIncludes(
                      content: widget.content,
                      chapterCount: totalChapters,
                    )),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: CourseDescription(content: widget.content)),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CourseInstructor(
                    coach: widget.coach,
                    isMobile: true,
                  ),
                ),
                ContentLayout(
                  title: "Related Courses",
                  listType: "",
                  objectType: "",
                  categoryType: '["COURSE"]',
                  related: widget.content.objectid,
                  showAll: AppRouter.courses,
                ),
              ],
            ),
          )),
    );
  }
}
