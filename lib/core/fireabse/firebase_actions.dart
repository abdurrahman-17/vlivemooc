import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/fireabse/firebase_constants.dart';
import 'package:vlivemooc/core/fireabse/firebase_realtime_database.dart';
import 'package:vlivemooc/core/helpers/time_calculator.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';
import '../storage/device_storage.dart';

final FirebaseRealtimeDatabase firebaseRealtimeDatabase =
    FirebaseRealtimeDatabase();
final FirebaseActions firebaseActions = FirebaseActions();

class FirebaseActions {
  Future<void> updateLikeDislikeFirebase(
      Datum content, String likeStatus) async {
    DatabaseReference? reference =
        await firebaseRealtimeDatabase.getContentReference(content);

    if (reference != null) {
      DataSnapshot snapshot =
          await reference.once().then((snapshot) => snapshot.snapshot);

      if (snapshot.value == null) {
        FireDatum fireContent = createFireContent(
          content,
          likeDisLikeStatus: likeStatus,
          watchedDuration: null,
          status: null,
        );
        reference.set(fireContent.toMap());
      } else {
        /*try {*/
        FireDatum? fireContent =
            FireDatum.fromSnapshot(snapshot.value as Map<dynamic, dynamic>);
        fireContent.updateBasicInfo(content);
        fireContent.likestatus = likeStatus;
        reference.update(fireContent.toMap());

        /* } catch (exp) {
          // do nothing
          print(exp.)
        }*/
      }
    }
  }

  FireDatum createFireContent(
    Datum content, {
    String? likeDisLikeStatus,
    bool? isWatchList,
    int? watchedDuration,
    String? status,
  }) {
    bool isEpisodeNode = firebaseRealtimeDatabase.isEpisode(content);
    FireDatum fireContent = FireDatum(
      objectid: content.objectid,
      objecttype: content.objecttype ?? "",
      category: content.category ?? "",
      title: content.title ?? "",
      genre: content.genre ?? "",
      poster: content.poster,
      contentStatus: StringConstants.active,
      duration: content.duration!,
      likestatus: likeDisLikeStatus,
      objectowner: content.objectowner,
    );

    if (isEpisodeNode) {
      fireContent.seriesid = content.seriesid;
      fireContent.seasonnum = content.seasonnum;
      fireContent.episodenum = int.parse(content.episodenum.toString())  ;
    }

    if (likeDisLikeStatus != null) {
      fireContent.likestatus = likeDisLikeStatus;
    }

    if (isWatchList != null) {
      fireContent.inwatchlist = isWatchList;
    }

    if (watchedDuration != null && status != null) {
      fireContent.watchedDuration = watchedDuration;
      fireContent.status = status;
    }
    fireContent.updatedAt = TimeCalculator().currentTime();


    return fireContent;
  }

// late SubscriberDetails subscriber;
  Future<bool> getUserLoggedIn() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String? subscriberData =
        sharedPreferences.getString(DeviceStorage.subscriberData);
    return subscriberData != null && subscriberData != "";
  }

  Future<bool> firebaseAddOrRemoveFromWatchList(
      Datum contentResponseData ,bool inWatchList) async {
    if (firebaseRealtimeDatabase.isEpisode(contentResponseData)) {
      await checkSeriesInsertedOrnot(contentResponseData);
    }
    //We have TO check user logged in or not?
    DatabaseReference? reference =
        await firebaseRealtimeDatabase.getContentReference(contentResponseData);
    if (reference != null) {
      DataSnapshot snapshot =
          await reference.once().then((snapshot) => snapshot.snapshot);
      if (snapshot.value != null) {
        FireDatum fireContent =
            FireDatum.fromSnapshot(snapshot.value as Map<dynamic, dynamic>);
        fireContent.updateBasicInfo(contentResponseData);
        fireContent.inwatchlist = inWatchList;
        reference.update(fireContent.toMap());
        return true;
      } else {
        FireDatum fireContent = createFireContent(
          contentResponseData,
          likeDisLikeStatus: FirebaseConstants.actionNone,
          watchedDuration: null,
          status: null,
        );
        fireContent.inwatchlist = !contentResponseData.inwatchlist;
        reference.set(fireContent.toMap()).then((value) => value);
        return true;
      }
    }

    return false;
  }


  updateCoursePercentage(
      {required Datum datum}) async {

    //Here user is logged in already and we are updating the course.
    DatabaseReference? reference =
        await firebaseRealtimeDatabase.getDirectContentReference(datum.objectid);
    if (reference != null) {
      DataSnapshot snapshot =
          await reference.once().then((snapshot) => snapshot.snapshot);
      if (snapshot.value != null) {
        FireDatum fireContent =
        FireDatum.fromSnapshot(snapshot.value as Map<dynamic, dynamic>);
        fireContent.updateBasicInfo(datum);
        fireContent.watchedDuration=datum.watchedDuration;
        reference.update(fireContent.toMap());

      }
    }
  }

  Future<bool> addInContinueWatching(Datum contentResponseData,
      BuildContext context, int watchedDuration, String status, callback) async {
    //We have TO check user logged in or not?
    if (!await getUserLoggedIn()) {
    callback();
      return false;
    }
    if (firebaseRealtimeDatabase.isEpisode(contentResponseData)) {
      await checkSeriesInsertedOrnot(contentResponseData);
    }

    DatabaseReference? reference =
        await firebaseRealtimeDatabase.getContentReference(contentResponseData);
    if (reference != null) {
      DataSnapshot snapshot =
          await reference.once().then((snapshot) => snapshot.snapshot);

      if (snapshot.value != null) {
        FireDatum fireContent =
            FireDatum.fromSnapshot(snapshot.value as Map<dynamic, dynamic>);
        fireContent.watchedDuration = watchedDuration;
        fireContent.status = status;
        //Update is watched once
        if(!(fireContent.isWatchedOnce??false)){
          fireContent.isWatchedOnce = status==StringConstants.completed;
        }
        fireContent.updatedAt = TimeCalculator().currentTime();
        reference.update(fireContent.toMap());
        return true;
      } else {
        FireDatum fireContent = createFireContent(
          contentResponseData,
          likeDisLikeStatus: FirebaseConstants.actionNone,
          watchedDuration: watchedDuration,
          status: status,
        );
        fireContent.isWatchedOnce = status==StringConstants.completed;
        reference.set(fireContent.toMap());
        return true;
      }
    }

    return false;
  }



//Call this only for series
  Future<bool> checkSeriesInsertedOrnot(
      Datum contentResponseData) async {
    var content = await getSeriesDetails(contentResponseData);
    DatabaseReference? reference =
    await firebaseRealtimeDatabase.getDirectContentReference(
        contentResponseData.seriesid!);
    if (reference != null) {
      DataSnapshot snapshot =
      await reference.once().then((snapshot) => snapshot.snapshot);
      if (snapshot.value == null) {
        if (content != null) {
          FireDatum fireContent = createFireContent(
            content,
            likeDisLikeStatus: FirebaseConstants.actionNone,
            watchedDuration: 0,
            status: "ACTIVE",
          );
          await reference.set(fireContent.toMap());
          return true;
        }
      } else {
        if(content!=null){
          FireDatum? fireContent =
          FireDatum.fromSnapshot(snapshot.value as Map<dynamic, dynamic>);
          fireContent.updateBasicInfo(content);
          reference.update(fireContent.toMap());
        }

        return true;
      }
    }

    return false;
  }

  Future<Datum?> getSeriesDetails(
      Datum contentResponseData) async {
    final response = await NetworkHandler.getContentDetail( contentResponseData.seriesid!);
    //Setting the total Duration of the series
    response.duration=response.totalduration;
    return response;
  }




  Future<List<FireDatum>> fetchContinueWatching() async {
    if (await getUserLoggedIn()) {
      var valueAtNode = await firebaseRealtimeDatabase.fetchFireContent();
      FirebaseConstants.fireContents = [];
      FirebaseConstants.fireContents.addAll(valueAtNode);
      return valueAtNode;
    } else {
      return [];
    }
  }

  void removeNode(String objectid) async {
    await firebaseRealtimeDatabase.removeContentNode(objectid);
  }

  removeFromWatchList({required FireDatum fireContentValue}) async {

    //Remove the node if it is not in watch history
    if (fireContentValue.likestatus == FirebaseConstants.actionNone &&
        fireContentValue.watchedDuration == 0) {
       removeNode(fireContentValue.objectid);
      return;
    }

    var contentRef = await firebaseRealtimeDatabase.contentReference();
    DatabaseReference? reference;
    FireDatum fireContent;
    reference = contentRef?.child(fireContentValue.objectid);
    DataSnapshot? snapshot =
        await reference?.once().then((snapshot) => snapshot.snapshot);
    fireContent =
        FireDatum.fromSnapshot(snapshot?.value as Map<dynamic, dynamic>);
    fireContent.inwatchlist = false;
    reference?.update(fireContent.toMap());
  }

  void fetchLikeDislikeStatusForAContent({required String subscriberId,required String objectid,required Function likeDisLikeStatus}) async {
      firebaseRealtimeDatabase.listenForAContentLikeStatus(
          changeInFireContent: (likeDisLikeStatus),
          subscriberId: subscriberId,
          objectId: objectid);


  }

  void fetchInWatchList({required String subscriberId,required String objectid,required Function inWatchList, Function? onNullValue}) async {
      firebaseRealtimeDatabase.listenForInWatchList(
          changeInFireContent: (inWatchList),
          subscriberId: subscriberId,
          objectId: objectid,
          onNullValue:onNullValue);


  }

  //Here we will calculate the progress of video &series.



 double getWatchedPercentage(FireDatum fireContent) {

    if(fireContent.objecttype==ContentModel.content)
      {
        return (fireContent.watchedDuration ?? 0) / (fireContent.duration??1);
      }else if(fireContent.episodes!=null){
      //For the series we get the watched duration of each episodes& sum it.
      int watchedDuration = 0;
      List<FireEpisode> episodes = fireContent.getEpisodesList();
      for(var episode in episodes){
        watchedDuration = watchedDuration+ episode.watchedDuration;
      }
      if(fireContent.duration!=null){
        return watchedDuration / (fireContent.duration??1);
      }

     }

    return 0;
  }
}
