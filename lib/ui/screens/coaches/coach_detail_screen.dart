import 'package:flutter/material.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/coaches/coach_detail_mobile.dart';

import '../../../core/models/coaches/coach_model/datum.dart';
import '../../../core/objects/content_tab_item.dart';
import '../../components/coaches/coach_detail_web.dart';
import '../../responsive/responsive.dart';

class CoachDetailScreen extends StatefulWidget {
  final Datum? coach;
  final String coachid;
  const CoachDetailScreen(
      {super.key, required this.coach, required this.coachid});

  @override
  State<CoachDetailScreen> createState() => _CoachDetailScreenState();
}

class _CoachDetailScreenState extends State<CoachDetailScreen> {
  Datum? coach;
  @override
  void initState() {
    super.initState();

    coach = widget.coach;
    if (coach == null) {
      getCoach(widget.coachid);
    } else {
      initializeContentTabs(coach!);
    }
  }

  getCoach(String? partnerid) async {
    if (partnerid == null) {
      return;
    }
    Datum datum = await NetworkHandler.getCoach(partnerid);
    setState(() {
      coach = datum;
    });
    initializeContentTabs(datum);
  }

  List<ContentTabItem> contentTabs = [];
  initializeContentTabs(Datum coach) {
    List<ContentTabItem> slugList = [];
    // slugList.add(ContentTabItem(
    //   tabName: "All",
    //   partnerid: coach.partnerid!,
    // ));
    slugList.add(ContentTabItem(
        tabName: "Videos",
        partnerid: coach.partnerid!,
        objectType: "CONTENT",
        categoryType: '["MOVIE"]'));
    slugList.add(ContentTabItem(
        tabName: "Courses",
        partnerid: coach.partnerid!,
        objectType: "SERIES",
        categoryType: '["COURSE"]'));

    slugList.add(ContentTabItem(
        tabName: "Events",
        partnerid: coach.partnerid!,
        objectType: "SERIES",
        categoryType: '["COURSE"]'));

    setState(() {
      contentTabs = slugList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (coach == null) {
      return const Scaffold(
        body: Center(
          child: LoadingAnimation(),
        ),
      );
    }
    return Responsive(
        mobileView: CoachDetailMobile(
          coach: coach!,
          tabList: contentTabs,
        ),
        desktopView: CoachDetailWeb(
          coach: coach!,
          tabList: contentTabs,
        ));
  }
}
