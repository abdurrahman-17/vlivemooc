import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/screens/courses/web_course_Play.dart';

import '../../responsive/responsive.dart';
import '../../../core/models/coaches/coach_model/datum.dart' as coachclass;
import 'mobile_course_Play.dart';

class CoursePlayScreen extends StatefulWidget {
  final Datum? content;
  final String contentid;
  final String moduleid;
  final String chapterid;
  const CoursePlayScreen(
      {super.key,
      required this.content,
      required this.contentid,
      required this.moduleid,
      required this.chapterid});

  @override
  State<CoursePlayScreen> createState() => _CoursePlayScreenState();
}

class _CoursePlayScreenState extends State<CoursePlayScreen> {
  Datum? content;
  coachclass.Datum? coach;
  String price = "";
  String currency = "";
  @override
  void initState() {
    super.initState();
    content = widget.content;
    if (content == null) {
      getContentPlay((content) {
        getCoach(content);
      });
    } else {
      getCoach(widget.content!);
    }
  }

  getCoach(Datum content) async {
    if (content.partnerid == null || content.partnerid.toString().isEmpty) {
      return;
    }
    coachclass.Datum? datum = await NetworkHandler.getCoach(content.partnerid!);
    setState(() {
      coach = datum;
    });
  }

  getContentPlay(onLoaded) async {
    Datum datum = await NetworkHandler.getContentDetail(widget.contentid);
    setState(() {
      content = datum;
    });
    onLoaded(datum);
  }

  @override
  Widget build(BuildContext context) {
    if (content == null) {
      return const Scaffold(
        body: Center(
          child: LoadingAnimation(),
        ),
      );
    }
    return Responsive(
        mobileView: MobileCoursePlay(
          content: content!,
          coach: coach,
          moduleid: widget.moduleid,
          chapterid: widget.chapterid,
        ),
        desktopView: WebCoursePlay(
          content: content!,
          coach: coach,
          moduleid: widget.moduleid,
          chapterid: widget.chapterid,
        ));
  }
}
