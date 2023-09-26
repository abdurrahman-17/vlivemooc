import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/helpers/time_calculator.dart';
import '../../../core/models/content/chapters/chapters_model/chapters_model.dart';
import '../../../core/models/content/modules/modules_model/datum.dart'
    as moduledatum;
import '../../../core/models/content/content_model/datum.dart';
import '../../../core/models/content/modules/modules_model/modules_model.dart';
import '../../../core/models/firebase/fire_datum.dart';
import '../../../core/provider/firebase_provider.dart';

class CourseContent extends StatefulWidget {
  final Datum content;
  final Function onDataReceived;
  final bool canRoute;
  final String selectedChapter;
  final String selectedModule;
  final Function? onSelectChange;
  const CourseContent(
      {super.key,
      required this.content,
      required this.onDataReceived,
      this.selectedModule = "",
      this.selectedChapter = "",
      this.onSelectChange,
      this.canRoute = true});

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  ModulesModel? modules;
  bool pageLoaded = false;
  bool allExpanded = false;
  String selectedChapter = "";
  String totalTimeInMins = "";
  @override
  void initState() {
    super.initState();
    selectedChapter = widget.selectedChapter;
    getData();
  }

  getData() async {
    String totalCount = "";
    int totalChapters = 0;
    int totalTimeInSeconds = 0;
    ModulesModel slugModules =
        await NetworkHandler.getModules(seriesid: widget.content.objectid);
    for (var i = 0; i < slugModules.totalcount!; i++) {
      ChaptersModel slugChapter = await NetworkHandler.getChapters(
          seriesid: widget.content.objectid, seasonnum: slugModules.data![i].seasonnum.toString());
      slugModules.data![i].chapter = slugChapter;

      if (slugModules.data![i].objectid == widget.selectedModule) {
        slugModules.data![i].isExpaned = true;
      }
      totalChapters = totalChapters + slugChapter.totalcount!;
      //Add chapters total duration to module
      int totalChaptersDuration=0;

      for (int j = 0; j < slugChapter.data!.length; j++) {
        var obj = slugChapter.data![j];
        totalTimeInSeconds = totalTimeInSeconds + obj.duration!;
        totalChaptersDuration=totalChaptersDuration+obj.duration!;
        if (obj.objectid == widget.selectedChapter) {
          if (widget.onSelectChange != null) {
            Datum contentObj = Datum.fromJson(obj.toJson());
            widget.onSelectChange!(contentObj);
          }
        }
      }
      slugModules.data![i].chaptersDuration = totalChaptersDuration;

    }
    totalCount = slugModules.totalcount!.toString();

    widget.onDataReceived(
        totalCount, totalChapters, totalTimeInSeconds ~/ 3600);

    setState(() {
      modules = slugModules;
      pageLoaded = true;
      totalTimeInMins = (totalTimeInSeconds ~/ 60).toString();
    });
  }

  setExpansion() {
    bool reversed = !allExpanded;
    ModulesModel? slugModules = modules;

    for (var i = 0; i < slugModules!.data!.length; i++) {
      slugModules.data![i].isExpaned = reversed;
    }
    setState(() {
      modules = slugModules;
      allExpanded = reversed;
    });
  }

  setAllExpanded() {
    bool expanded = false;
    for (var i = 0; i < modules!.data!.length; i++) {
      if (modules!.data![i].isExpaned) {
        expanded = true;
        break;
      }
    }
    setState(() {
      allExpanded = expanded;
    });
  }

  onSelectChange(value, data) {
    if (widget.onSelectChange != null) {
      Datum contentObj = Datum.fromJson(data.toJson());

      widget.onSelectChange!(contentObj);
    }
    setState(() {
      selectedChapter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return pageLoaded
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !widget.canRoute ?  CourseProgress(content:widget.content) : Container(),
              !widget.canRoute
                  ? const SizedBox(
                      height: Constants.semanticMarginDefault,
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Course Content",
                        style: TextStyle(
                            fontSize: Constants.fontSizeMedium,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "${modules!.totalcount} Modules | $totalTimeInMins minutes"),
                    ],
                  ),
                  TextButton.icon(
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryColor),
                      onPressed: () {
                        setExpansion();
                      },
                      icon: allExpanded
                          ? const Icon(Icons.arrow_upward)
                          : const Icon(Icons.arrow_downward),
                      label: Text(allExpanded ? "Collapse All" : "Expand All"))
                ],
              ),
              const SizedBox(
                height: Constants.semanticsMarginExSmall,
              ),
              ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    modules!.data![index].isExpaned = !isExpanded;
                  });
                   setAllExpanded();
                },
                children: modules!.data!
                    .map<ExpansionPanel>((moduledatum.ModuleDatum content) {
                  return ExpansionPanel(
                      isExpanded: content.isExpaned,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Padding(
                          padding: EdgeInsets.all(Constants.insetPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(content.title!),
                              Text(
                                "${content.episodecount} Chapters | ${(content.chaptersDuration??0)~/60} Mins",
                                style: const TextStyle(
                                    fontSize: Constants.fontSizeSmall),
                              )
                            ],
                          ),
                        );
                      },
                      body: ListView.builder(
                          shrinkWrap: true,
                          itemCount: content.chapter!.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            var data = content.chapter!.data![index];
                            return InkWell(
                              onTap: widget.canRoute
                                  ? () {
                                      RouteGenerator().navigate(
                                          context,
                                          RouteGenerator
                                              .generateCoursePlayRoute(
                                                  content: widget.content,
                                                  moduleid: content.objectid!,
                                                  chapterid: data.objectid!),
                                          extra: widget.content);
                                    }
                                  : () {
                                      onSelectChange(data.objectid!, data);
                                    },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16, left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          widget.canRoute
                                              ? Icon(
                                                  Icons.play_arrow,
                                                  size: 20,
                                                  color: AppColors.primaryColor,
                                                )
                                              : Radio(
                                                  value: data.objectid,
                                                  groupValue: selectedChapter,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          AppColors
                                                              .primaryColor),
                                                  onChanged: (value) {
                                                    onSelectChange(value, data);
                                                  },
                                                ),
                                          const SizedBox(
                                            width:
                                                Constants.semanticMarginDefault,
                                          ),
                                          Expanded(
                                            child: Text(
                                              data.title!,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize:
                                                      Constants.fontSizeSmall),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: Constants.semanticMarginDefault,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          widget.canRoute
                                              ? Text(
                                                  "Preview",
                                                  style: TextStyle(
                                                      fontSize: Constants
                                                          .fontSizeSmall,
                                                      color: AppColors
                                                          .primaryColor),
                                                )
                                              : Container(),
                                          widget.canRoute
                                              ? const SizedBox(
                                                  width: Constants
                                                      .semanticMarginDefault,
                                                )
                                              : Container(),
                                          Expanded(
                                            child: Text(
                                              "Video|${TimeCalculator().formatTimetoMinsSecsFromSec(timeInSecond: data.duration)}",
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  fontSize:
                                                      Constants.fontSizeSmall),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                }).toList(),
              )
            ],
          )
        : const LoadingAnimation();
  }
}

class CourseProgress extends StatefulWidget {
  final Datum content;
  const CourseProgress( {super.key,required this.content,});

  @override
  State<CourseProgress> createState() => _CourseProgressState();
}

class _CourseProgressState extends State<CourseProgress> {

  @override
  void didChangeDependencies() {
    FirebaseProvider model = Provider.of<FirebaseProvider>(context);
    model.fetchContentFromFirebase(widget.content, context, onFetchContinueWatching);
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text(
          " ${fireContent==null?0:(firebaseActions.getWatchedPercentage(fireContent!)*100).round()}% Complete",
          style: const TextStyle(fontSize: Constants.fontSizeSmall),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        Container(
          height: 6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: LinearProgressIndicator(
            value: fireContent==null?0:firebaseActions.getWatchedPercentage(fireContent!),
            backgroundColor: Colors.grey.shade500,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
  FireDatum? fireContent;
  onFetchContinueWatching(FireDatum fireContentData) {
    setState(() {
      fireContent=fireContentData;
    });
  }
}
