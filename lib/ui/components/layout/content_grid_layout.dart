import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/content/chapters/chapters_model/chapters_model.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/components/cards/content_card.dart';
import 'package:vlivemooc/ui/components/cards/content_card_shimmer.dart';
import 'package:vlivemooc/ui/components/layout/grid_layout_shimmer.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/helpers/app_screen_dimen.dart';

class ContentGridLayout extends StatefulWidget {
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
  final bool paginationEnabled;
  final bool shrinkWrap;
  final Function? onLoadCallback;
  final Function? onContentLoaded;

  const ContentGridLayout({
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
    this.shrinkWrap = false,
    this.seriesId = "",
    this.onLoadCallback,
    this.paginationEnabled = false,
    this.onContentLoaded,
  });

  @override
  State<ContentGridLayout> createState() => _ContentGridLayoutState();
}

class _ContentGridLayoutState extends State<ContentGridLayout> {
  ContentModel? contentModel;

  int page = 1;
  bool initialRequested = false;
  bool showShimmer = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if ((_scrollController.position.maxScrollExtent-_scrollController.position.pixels)<Constants.categoryCardDimensHight) {
        if (requestCompleted &&
            (contentModel?.totalcount ?? 0) > dataList.length) {
          setState(() {
            page = page + 1;
            showShimmer = true;
          });
          getContent(page);
        }
      }
    });
    getContent(page);
  }

  bool requestCompleted = false;
  int index = -1;
  List<Datum> dataList = [];

  getContent(int page) async {
    if (widget.related.isNotEmpty) {
      try {
        ContentModel model = await NetworkHandler.getContent(widget.listType,
            objecttype: widget.objectType,
            category: widget.categoryType,
            partnerid: widget.partnerid,
            genre: widget.idgenre);
        setState(() {
          // contentModel = model;
          contentModel!.data!.addAll(model.data!);
          requestCompleted = true;
          showShimmer = false;
        });
        if (widget.onContentLoaded != null) {
          widget.onContentLoaded!();
        }
      } catch (error) {
        setState(() {
          requestCompleted = true;
          showShimmer = false;
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
            pagesize: Constants.getContentPageSize,
            page: page,
          );
        }

        setState(() {
          contentModel = model;
          dataList.addAll(model!.data!);
          // contentModel!.data!.addAll(model!.data!);
          requestCompleted = true;
          showShimmer = false;
        });
        if (widget.onContentLoaded != null) {
          widget.onContentLoaded!();
        }
        if (widget.onLoadCallback != null) {
          widget.onLoadCallback!(model);
        }
      } catch (error) {
        setState(() {
          showShimmer = false;
          requestCompleted = true;
        });
      }
    }
  }

  final ScrollController _scrollController = ScrollController();

  bool canScroll = false;
  bool reachedEnd = false;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = 4;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 900) {
      crossAxisCount = 2;
    }

    if (contentModel == null && !requestCompleted) {
      return const GridLayoutShimmer();
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
      child: GridView.builder(
          shrinkWrap: widget.shrinkWrap,
          controller: _scrollController,
          itemCount: showShimmer ? dataList.length + 4 : dataList.length,
          gridDelegate: isMobile(context)
              ? SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent:(width-Constants.semanticMarginTen) ,
              crossAxisSpacing: Constants.semanticMarginTen,
              mainAxisSpacing: Constants.insetPadding,
              crossAxisCount: crossAxisCount)
              : SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 350,
              crossAxisSpacing: Constants.semanticMarginTen,
              mainAxisSpacing: Constants.insetPadding,
              maxCrossAxisExtent: Constants.maxContentCardWidthWeb2),
          itemBuilder: (BuildContext context, int index) {
            if (index < dataList.length) {
              Datum datum = dataList[index];
              return ContentCard(
                content: datum,
                idgenre: widget.idgenre,
              );
            } else {
              return const ContentCardShimmer();
            }
          }),
    );
  }
}
