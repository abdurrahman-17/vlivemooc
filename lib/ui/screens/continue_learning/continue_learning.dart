import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../../core/helpers/image_filters.dart';
import '../../../core/models/subscriber/subscriber_model.dart';
import '../../../core/provider/provider_constants.dart';
import '../../../core/provider/user_provider.dart';
import '../../components/layout/content_layout_shimmer.dart';
import '../../constants/constants.dart';
import 'continue_learning_card.dart';



class ContinueLearning extends StatefulWidget {
  final String title;
  final bool isOnlyVidoes;

  const ContinueLearning(
      {super.key, required this.title, required this.isOnlyVidoes});

  @override
  State<ContinueLearning> createState() => _ContinueLearningState();
}

class _ContinueLearningState extends State<ContinueLearning> {

  bool isLoading = true;
  List<FireDatum> continueWatchingVideo = [];


  @override
  void didChangeDependencies() {
    fetchCoursesFromFirebase();
    super.didChangeDependencies();
  }

  StreamSubscription<DatabaseEvent>? streamSubscription;
  void fetchCoursesFromFirebase() {
    if(!ProviderConstants.isLoggedIn)
    {
      setState(() {
        isLoading=false;
      });
      return;
    }
    //Fetch subscriber and then get the fire contents
    SubscriberModel? model = Provider.of<UserProvider>(context).subscriberModel;
    if (model != null) {
      streamSubscription =  firebaseRealtimeDatabase.listenForContinueLearningChanges(
          changeInFireContent: onFireContentFetched,
          subscriberId: model.subscriberId);
    }else{
      setState(() {
        isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double cardHeight= getLandscapeImageHeight(isMobile(context)?230: MediaQuery.of(context).size.width / 4.4);
    return (continueWatchingVideo.isEmpty&& !isLoading)?Container():Container(
      padding:const EdgeInsets.fromLTRB(10, 5, 10, 10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: Constants.fontSizeLarge,
                fontWeight: FontWeight.bold),
          ),


          isLoading
              ? const ContentLayoutShimmer()
              : SizedBox(
            height: cardHeight+(isMobile(context)?100:105),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: continueWatchingVideo.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ContinueLearningCard(fireContent: continueWatchingVideo[index],);
              },
            ),
          ),
        ],
      ),
    );
  }

  onFireContentFetched(List<FireDatum> fireContent) {

    setState(() {
      isLoading = false;
      continueWatchingVideo.clear();
      if (widget.isOnlyVidoes) {
        continueWatchingVideo.addAll(
            fireContent.where((element) =>
            (element.objecttype ==
                StringConstants.content && (element.status==StringConstants.inProgress)))
                .toList());
      } else {
        continueWatchingVideo.addAll(
            fireContent.where((element) =>
            ((element.objecttype == StringConstants.series &&
                element.episodes != null) ||
                ((element.status==StringConstants.inProgress))))
                .toList());
      }
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }
}
