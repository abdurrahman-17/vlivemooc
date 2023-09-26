import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/ui/components/account/login_prompt.dart';
import 'package:vlivemooc/ui/components/mylearnings/mywatch_history_card.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';
import '../../../core/fireabse/firebase_actions.dart';
import '../../../core/models/subscriber/subscriber_model.dart';
import '../../../core/provider/user_provider.dart';
import '../../animations/loading_animation.dart';
import '../../constants/constants.dart';
import '../appbar/mobile_app_bar_without_icon.dart';

class MyWatchHistory extends StatefulWidget {
  final bool isWatchHistory;
  final bool isMobile;

  const MyWatchHistory(
      {super.key, this.isWatchHistory = true, required this.isMobile});

  @override
  State<MyWatchHistory> createState() => _MyWatchHistoryState();
}

class _MyWatchHistoryState extends State<MyWatchHistory> {
  List<FireDatum> fireContents = [];
  bool isLoading = true;
  bool isUserLogged = false;

  onFetchedFirebaseContents(List<FireDatum> fireContentsData) {

    setState(() {
      isLoading = false;
      //Add to continuous learning only if the user watched some seconds and it is a series
      if (widget.isWatchHistory) {
        fireContents = fireContentsData
            .where((element) =>
                element.watchedDuration != null &&
                element.objecttype == StringConstants.content && (element.status==StringConstants.inProgress))
            .toList();
      } else {
        fireContents = fireContentsData
            .where((element) => element.inwatchlist ?? false)
            .toList();
      }
    });
  }

  @override
  void didChangeDependencies() {
    fetchCoursesFromFirebase();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return watchListBody(context);
  }

  Widget watchListBody(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: LoadingAnimation(),
      );
    }

    return Scaffold(
      appBar: (widget.isWatchHistory||!widget.isMobile)
          ? null
          : const MobileAppBarWithoutIcon(
              title: Constants.watchList,
            ),
      body: !isUserLogged
          ? Center(
              child: LoginPrompt(
                  message: (widget.isWatchHistory
                      ? "Please login to see your Watch history"
                      : "Please login to see your Watchlist")),
            )
          : fireContents.isEmpty
              ? Center(
                  child: Text(
                  widget.isWatchHistory
                      ? StringConstants.emptyWatchHistory
                      : StringConstants.emptyWatchList,
                  style: poppinsBold(15, AppColors.textLight1),
                ))
              : Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: fireContents.length,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MyWatchHistoryCard(
                                isMobile: widget.isMobile,
                                isWatchHistory: widget.isWatchHistory,
                                fireContent: fireContents[index]),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 0,
                          );
                        },
                      ),
                    )
                  ],
                ),
    );
  }

  StreamSubscription<dynamic>? streamSubscription;


  void fetchCoursesFromFirebase() {
    //Fetch subscriber and then get the fire contents
    SubscriberModel? model = Provider.of<UserProvider>(context).subscriberModel;
    if (model != null) {
      setState(() {
        isUserLogged = true;
        isLoading = true;
      });
      streamSubscription= firebaseRealtimeDatabase.listenForContinueLearningChanges(
          changeInFireContent: onFetchedFirebaseContents,
          subscriberId: model.subscriberId);
    } else {
      setState(() {
        isUserLogged = false;
        isLoading = false;
      });
    }
  }
  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }
}
