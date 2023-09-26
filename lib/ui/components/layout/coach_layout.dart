import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/coaches/coach_model/coach_model.dart';
import 'package:vlivemooc/ui/components/cards/coach_card.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../../core/models/coaches/coach_model/datum.dart';
import '../../../core/network/network_handler.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class CoachLayout extends StatefulWidget {
  const CoachLayout({super.key});
  @override
  State<CoachLayout> createState() => _CoachLayoutState();
}

class _CoachLayoutState extends State<CoachLayout> {
  List<Datum>? coaches;

  @override
  void initState() {
    super.initState();
    getCoaches();
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

  getCoaches() async {
    CoachModel model = await NetworkHandler.getCoaches();
    List<Datum> coachesFiltered = [];
    for (var i = 0; i < model.data!.length; i++) {
      Datum datum = model.data![i];
      if (datum.profilepicture != null && datum.partnername != null&& datum.status ==StringConstants.active) {
        coachesFiltered.add(datum);
      }
    }
    setState(() {
      coaches = coachesFiltered;
    });
  }

  final ScrollController _controller = ScrollController();
  bool isScrollStart = false;
  bool isScrollEnd = true;

  void _scrollTo(bool forward) {
    double scrollTo = _controller.position.pixels;
    double sensitivity = 150;
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
    if (coaches == null) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.insetPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Coaches",
            style: TextStyle(
                fontSize: Constants.fontSizeLarge, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: coaches!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Datum datum = coaches![index];
                      return SizedBox(
                        width: 200,
                        child: CoachCard(
                          coach: datum,
                        ),
                      );
                    }),
              ),
              Positioned(
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
              ),
              Positioned(
                right: 0,
                child: Visibility(
                  visible: isScrollEnd,
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
            ],
          )
        ],
      ),
    );
  }
}
