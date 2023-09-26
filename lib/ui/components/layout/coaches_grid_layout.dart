import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/coaches/coach_model/coach_model.dart';
import 'package:vlivemooc/ui/components/cards/coach_card.dart';
import 'package:vlivemooc/ui/components/layout/grid_layout_shimmer.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/coaches/coach_model/datum.dart';
import '../../../core/network/network_handler.dart';
import '../../constants/string_constants.dart';

class CoachesGridLayout extends StatefulWidget {
  final Function? onLoadCallback;
  final String category;
  final List<Datum>? coaches;
  const CoachesGridLayout(
      {super.key, this.onLoadCallback, this.category = "", this.coaches});

  @override
  State<CoachesGridLayout> createState() => _CoachesGridLayoutState();
}

class _CoachesGridLayoutState extends State<CoachesGridLayout> {
  @override
  void initState() {
    super.initState();
    if (widget.coaches != null) {
      coaches = widget.coaches;
    } else {
      getCoaches();
    }
  }

  List<Datum>? coaches;
  final ScrollController _scrollController = ScrollController();

  getCoaches() async {
    CoachModel model = await NetworkHandler.getCoaches();
    List<Datum> coachesFiltered = [];
    for (var i = 0; i < model.data!.length; i++) {
      Datum datum = model.data![i];
      if (datum.profilepicture != null &&
          datum.partnername != null &&
          datum.status == StringConstants.active) {
        if (widget.category.isNotEmpty) {
          if (datum.tags != null && datum.tags!.contains(widget.category)) {
            coachesFiltered.add(datum);
          }
        } else {
          coachesFiltered.add(datum);
        }
      }
    }
    setState(() {
      coaches = coachesFiltered;
    });
    if (widget.onLoadCallback != null) {
      widget.onLoadCallback!(model);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = 4;
    if (width < 400) {
      crossAxisCount = 2;
    } else if (width < 600) {
      crossAxisCount = 2;
    } else if (width < 900) {
      crossAxisCount = 3;
    }

    if (coaches == null) {
      return const GridLayoutShimmer();
    }
    if (widget.coaches != null && widget.coaches!.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: Text("No coaches found"),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(Constants.insetPadding),
      child: GridView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: coaches!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: Constants.insetPadding),
          itemBuilder: (BuildContext context, int index) {
            Datum datum = coaches![index];
            return CoachCard(
              coach: datum,
            );
          }),
    );
  }
}
