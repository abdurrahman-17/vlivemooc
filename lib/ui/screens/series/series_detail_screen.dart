import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';

import '../../components/series/series_detail.dart';
import '../../responsive/responsive.dart';

class SeriesDetailScreen extends StatefulWidget {
  final Datum? content;
  final String contentid;
  const SeriesDetailScreen(
      {super.key, required this.content, required this.contentid});

  @override
  State<SeriesDetailScreen> createState() => _SeriesDetailScreenState();
}

class _SeriesDetailScreenState extends State<SeriesDetailScreen> {
  Datum? content;
  @override
  void initState() {
    super.initState();
    content = widget.content;
    if (content == null) {
      getContentDetail();
    }
  }

  getContentDetail() async {
    Datum datum = await NetworkHandler.getContentDetail(widget.contentid);
    setState(() {
      content = datum;
    });
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
        mobileView: SeriesDetail(
          isMobile: true,
          content: content!,
        ),
        desktopView: SeriesDetail(
          isMobile: false,
          content: content!,
        ));
  }
}
