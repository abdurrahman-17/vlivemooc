import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../../core/fireabse/firebase_actions.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/subscriber/subscriber_model.dart';
import '../../../core/provider/user_provider.dart';
import '../../animations/loading_animation.dart';
import 'mycourse_learning_card.dart';

class MyCourses extends StatefulWidget {
  final bool isVideos;
  final bool isMobile;
  const MyCourses({super.key, this.isVideos = false, required this.isMobile});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  List<FireDatum> fireContents = [];
  bool isLoading = true;

  onFetchedFirebaseContents(List<FireDatum> fireContentsData) {
    setState(() {
      isLoading = false;

      //Add firecontents
      if (fireContentsData.isNotEmpty) {
        //Clear all the data before adding.
        fireContents.clear();
        for (var fireContent in fireContentsData) {
          //Add to continuous learning only if the user watched some seconds and it is a series
          if (fireContent.watchedDuration != null && fireContent.objecttype==StringConstants.content&&
              fireContent.watchedDuration! > 0&& widget.isVideos) {
            fireContents.add(fireContent);
          }
         else if (fireContent.objecttype == StringConstants.series &&
              fireContent.category == StringConstants.course && !widget.isVideos) {
            fireContents.add(fireContent);
          }
        }
      }


    });

  }
  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isLoading) {
      fetchCoursesFromFirebase();
    }
    super.didChangeDependencies();

  }
  @override
  Widget build(BuildContext context) {


    if (isLoading) {
      return const Center(
        child: LoadingAnimation(),
      );
    }
    return (fireContents.isEmpty)
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: Text(
              widget.isVideos
                  ? StringConstants.emptyWatchHistory
                  : StringConstants.startLearning,
              style: poppinsBold(15, AppColors.textLight1),
            )))
        : SingleChildScrollView(
            child: Container(
              color:
                  widget.isMobile ? AppColors.greyColor5 : Colors.transparent,
              child: Column(
                children: [
                  /*SizedBox(
                      height: 15,
                    ),
                    getProgressAndSort(),*/
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: fireContents.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: MyCourseLearningCard(
                            isMobile: widget.isMobile,
                            fireContent: fireContents[index]),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 0,
                      );
                    },
                  )
                ],
              ),
            ),
          );
  }

  StreamSubscription<DatabaseEvent>? streamSubscription;

  void fetchCoursesFromFirebase() {
    //Fetch subscriber and then get the fire contents
    SubscriberModel? model = Provider.of<UserProvider>(context).subscriberModel;
    if (model != null) {
      streamSubscription=  firebaseRealtimeDatabase.listenForContinueLearningChanges(
          changeInFireContent: onFetchedFirebaseContents,
          subscriberId: model.subscriberId);
    }
  }
}
