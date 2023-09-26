import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/cards/instructor_course_card.dart';
import 'package:vlivemooc/ui/components/courses/about_the_course.dart';
import 'package:vlivemooc/ui/components/courses/course_playback.dart';
import '../../../core/models/coaches/coach_model/datum.dart' as coachclass;
import '../../../core/models/content/content_model/datum.dart';
import '../../components/appbar/top_bar.dart';
import '../../components/courses/course_content.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class WebCoursePlay extends StatefulWidget {
  final Datum content;
  final coachclass.Datum? coach;
  final String moduleid;
  final String chapterid;

  const WebCoursePlay(
      {super.key,
      required this.content,
      required this.coach,
      required this.moduleid,
      required this.chapterid});

  @override
  State<WebCoursePlay> createState() => _WebCoursePlayState();
}

class _WebCoursePlayState extends State<WebCoursePlay> {
  Datum? chapter;

  @override
  void initState() {
    super.initState();
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
            child: Container(
          padding: const EdgeInsets.all(50),
          color: AppColors.accentColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      CoursePlayback(
                        content: widget.content,
                        chapter: chapter,
                      ),
                      const SizedBox(
                        height: Constants.semanticMarginDefault,
                      ),
                      AboutTheCourse(content: widget.content)
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    CourseContent(
                      canRoute: false,
                      content: widget.content,
                      selectedChapter: widget.chapterid,
                      selectedModule: widget.moduleid,
                      onDataReceived: (x, y, z) {},
                      onSelectChange: (content) {
                        setState(() {
                          chapter = content;
                        });
                      },
                    ),
                    const SizedBox(
                      height: Constants.semanticMarginDefault,
                    ),
                    widget.coach != null
                        ? InstructorCourseCard(
                            isMobile: false, coach: widget.coach!)
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
