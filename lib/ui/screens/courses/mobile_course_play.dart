import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/cards/instructor_course_card.dart';
import 'package:vlivemooc/ui/components/courses/about_the_course.dart';
import 'package:vlivemooc/ui/components/courses/course_playback.dart';
import '../../../core/models/coaches/coach_model/datum.dart' as coachclass;
import '../../../core/models/content/content_model/datum.dart';
import '../../components/appbar/mobile_app_bar.dart';
import '../../components/courses/course_content.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class MobileCoursePlay extends StatefulWidget {
  final Datum content;
  final coachclass.Datum? coach;
  final String moduleid;
  final String chapterid;

  const MobileCoursePlay(
      {super.key,
      required this.content,
      required this.coach,
      required this.moduleid,
      required this.chapterid});

  @override
  State<MobileCoursePlay> createState() => _MobileCoursePlayState();
}

class _MobileCoursePlayState extends State<MobileCoursePlay> {
  Datum? chapter;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: true,
      right: true,
      bottom: true,
      child: Scaffold(
          appBar: MobileAppBar(
            title: widget.content.title!,
          ),
          body: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.accentColor,
                  child: Column(
                    children: [
                      CoursePlayback(
                        content: widget.content,
                        chapter: chapter,
                      ),
                      const SizedBox(
                        height: Constants.semanticMarginDefault,
                      ),
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
                      AboutTheCourse(content: widget.content),
                      const SizedBox(
                        height: Constants.semanticMarginDefault,
                      ),
                      widget.coach != null
                          ? InstructorCourseCard(
                              isMobile: false, coach: widget.coach!)
                          : Container(),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  )))),
    );
  }
}
