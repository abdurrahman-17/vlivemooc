import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/models/content/chapters/chapters_model/chapters_model.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/components/cards/content_card.dart';
import 'package:vlivemooc/ui/components/layout/content_layout_shimmer.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/helpers/app_screen_dimen.dart';

class ContentLayout extends StatefulWidget {
  final String title;
  final String objectType;
  final String listType;
  final String categoryType;
  final String partnerid;
  final String related;
  final String idgenre;
  final String showAll;
  final bool renderScrollButtons;
  final bool renderEmpty;
  final bool shouldRoutePush;
  final bool isEpisode;
  final String seriesId;
  final Function? onLoadCallback;
  const ContentLayout({
    super.key,
    required this.title,
    required this.objectType,
    required this.listType,
    required this.categoryType,
    this.related = "",
    this.partnerid = "",
    this.idgenre = "",
    this.showAll = "",
    this.renderScrollButtons = true,
    this.renderEmpty = false,
    this.isEpisode = false,
    this.shouldRoutePush = false,
    this.seriesId = "",
    this.onLoadCallback,
  });

  @override
  State<ContentLayout> createState() => _ContentLayoutState();
}

class _ContentLayoutState extends State<ContentLayout> {
  ContentModel? contentModel;
  @override
  void initState() {
    super.initState();
    getContent();
    _controller.addListener(() {
      setState(() {
        isScrollStart = true;
        isScrollEnd = true;
      });
      if (_controller.position.atEdge) {
        bool isStart = _controller.position.pixels == 0;
        if (isStart) {
          setState(() {
            isScrollStart = false;
            isScrollEnd = true;
          });
        } else {
          setState(() {
            isScrollStart = true;
            isScrollEnd = false;
          });
        }
      }
    });
  }

  bool requestCompleted = false;
  getContent() async {
    if (widget.related.isNotEmpty) {
      try {
        ContentModel model =
        await NetworkHandler.getRelatedContent(contentid: widget.related);
        setState(() {
          contentModel = model;
          requestCompleted = true;
        });
        checkCanScroll();
      } catch (error) {
        setState(() {
          requestCompleted = true;
        });
      }
      return;
    } else {
      try {
        ContentModel? model;
        if (widget.isEpisode) {
          ChaptersModel chaptersModel = await NetworkHandler.getChapters(
              seriesid: widget.seriesId, seasonnum: "1");
          model = ContentModel.fromJson(chaptersModel.toJson());
        } else {
          model = await NetworkHandler.getContent(
            widget.listType,
            objecttype: widget.objectType,
            category: widget.categoryType,
            partnerid: widget.partnerid,
            genre: widget.idgenre,
          );
        }

        setState(() {
          contentModel = model;
          requestCompleted = true;
        });
        checkCanScroll();
        if (widget.onLoadCallback != null) {
          widget.onLoadCallback!(model);
        }
      } catch (error) {
        setState(() {
          requestCompleted = true;
        });
      }
    }
  }

  final ScrollController _controller = ScrollController();
  bool isScrollStart = false;
  bool isScrollEnd = true;
  bool canScroll = false;

  checkCanScroll() {
    Timer(const Duration(milliseconds: 500), () {
      try {
        setState(() {
          canScroll = _controller.position.maxScrollExtent > 0;
        });
      } catch (controllerNotAttached) {
        //do nothing
      }
    });
  }

  void _scrollTo(bool forward) {
    double scrollTo = _controller.position.pixels;
    double sensitivity = Constants.scrollSensitivity;
    if (forward) {
      scrollTo = scrollTo + sensitivity;
    } else {
      scrollTo = scrollTo - sensitivity;
    }
    _controller.animateTo(
      scrollTo,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (contentModel == null && !requestCompleted) {
      return const ContentLayoutShimmer();
    } else if (contentModel == null && requestCompleted && widget.renderEmpty) {
      return Container();
    } else if (contentModel == null && requestCompleted) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: Constants.insetPadding),
        child: const Text(
          "No content available",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: Constants.fontSizeMedium),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.insetPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: Constants.fontSizeLarge,
                      fontWeight: FontWeight.bold),
                ),
              ),
              widget.showAll.isEmpty
                  ? Container()
                  : TextButton(
                  onPressed: () {
                    context.go(widget.showAll);
                  },
                  child: Text(
                    "Show All",
                    style: TextStyle(color: AppColors.primaryColor),
                  ))
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: isMobile(context) ? 315 : 325,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: contentModel!.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Datum datum = contentModel!.data![index];
                      return SizedBox(
                        width: isMobile(context) ? 240 : Constants.maxContentCardWidthWeb,
                        child: ContentCard(
                          content: datum,
                          shouldRoutePush: widget.shouldRoutePush,
                          idgenre: widget.idgenre,
                        ),
                      );
                    }),
              ),
              widget.renderScrollButtons
                  ? Positioned(
                left: 0,
                child: Visibility(
                  visible: isScrollStart,
                  maintainAnimation: true,
                  maintainState: true,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    opacity: isScrollStart ? 1 : 0,
                    child: FloatingActionButton.small(
                      heroTag: UniqueKey().toString(),
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        _scrollTo(false);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              )
                  : Container(),
              widget.renderScrollButtons
                  ? Positioned(
                right: 0,
                child: Visibility(
                  visible: isScrollEnd && canScroll,
                  maintainAnimation: true,
                  maintainState: true,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    opacity: isScrollEnd ? 1 : 0,
                    child: FloatingActionButton.small(
                      heroTag: UniqueKey().toString(),
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        _scrollTo(true);
                      },
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              )
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
