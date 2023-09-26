import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/fireabse/firebase_constants.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/subscriber/subscriber_model.dart';
import 'package:vlivemooc/core/storage/device_storage.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';
import '../models/firebase/fire_datum.dart';
import '../network/urls.dart';

final firebaseApp = Firebase.app();
final rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp, databaseURL: AppUrls.firebaseUrl);
final DatabaseReference _database = rtdb.ref();

class FirebaseRealtimeDatabase {
  void writeNodeValue(String firebaseRef, var valuesToSet) {
    _database.child(firebaseRef).set(valuesToSet).catchError((error) {});
  }

  Future<bool> checkIfNodeExists(String nodePath) async {
    return await fetchNode(nodePath) != null;
  }

  Future<Object?> fetchNode(String nodePath) async {
    DatabaseReference databaseReference = _database.child(nodePath);

    DataSnapshot dataSnapshot =
        await databaseReference.once().then((snapshot) => snapshot.snapshot);

    return dataSnapshot.value;
  }

  Future<List<FireDatum>> fetchFireContent() async {
    var reference = await contentReference();
    List<FireDatum> fireContents = [];

    if (reference != null) {
      DataSnapshot dataSnapshot =
          await reference.once().then((snapshot) => snapshot.snapshot);

      if (dataSnapshot.value != null) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(dataSnapshot.value));

        data.forEach((key, value) {
          FireDatum fireContent = FireDatum.fromSnapshot(value);

          fireContents.add(fireContent);
        });
      }
    }
    return fireContents;
  }

  /// Returns the Firebase database reference path base on the [content] object
  ///
  /// Path points to either:
  ///
  /// subscriber/<[subscriberid]>/<[profileid]>/content/<[objectid]>
  ///
  /// or
  ///
  /// /subscriber/<[subscriberid]>/<[profileid]>/content/<[objectid]>/episodes/<[objectid]>
  ///
  /// @param content [Content] object
  /// @author Mohan
  /// @return [DatabaseReference] nullable
  Future<DatabaseReference?> getContentReference(Datum content) async {
    var contentRef = await contentReference();
    if (isEpisode(content)) {
      return contentRef
          ?.child(content.seriesid)
          .child(StringConstants.episodes)
          .child(content.objectid);
    } else {
      return contentRef?.child(content.objectid);
    }
  }

  bool isEpisode(Datum content) {
    return content.objecttype == StringConstants.content &&
        content.seriesid != null;
  }

  Future<DatabaseReference?> getDirectContentReference(String objectid) async {
    var contentRef = await contentReference();
    return contentRef?.child(objectid);
  }

  Future<DatabaseReference?> contentReference() async {
    var subscriberRefer = await subscriberReference();
    return subscriberRefer?.child(StringConstants.pathContent);
  }

  Future<DatabaseReference?> subscriberReference() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String? subscriberData =
        sharedPreferences.getString(DeviceStorage.subscriberData);

    if (subscriberData == null || subscriberData == "") {
      return null;
    } else {
      SubscriberModel subscriberModel =
          SubscriberModel.fromJson(subscriberData);
      return _database
          .child("EnrichTv/${StringConstants.subscriber}")
          .child(subscriberModel.subscriberId)
          .child(subscriberModel.subscriberId);
    }
  }

  /// THis function is to continously listen for the changes in firebase content for specified user
   listenForContinueLearningChanges(
      {required Function changeInFireContent,
      required String subscriberId})  {
    DatabaseReference starCountRef = _database.child(
        'EnrichTv/${StringConstants.subscriber}/$subscriberId/$subscriberId/${StringConstants.pathContent}');

   return starCountRef.onValue.listen((DatabaseEvent event) {
      final response = event.snapshot.value;
      //updateStarCount(data);

      List<FireDatum> fireContents = [];
      if (response != null) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(response));

        data.forEach((key, value) {
          try {
            FireDatum fireContent = FireDatum.fromSnapshot(value);
            fireContents.add(fireContent);
            if (kDebugMode) {
              print("Updated At");
              print(fireContent.updatedAt);
            }
          } catch (e) {
            if (kDebugMode) {
              print(e.toString());
            }
          }
        });
        fireContents.sort((c2, c1) => c1.updatedAt!.compareTo(c2.updatedAt!));
        changeInFireContent(fireContents);
      } else {
        changeInFireContent(fireContents);
      }
    });

  }

  listenForEpisodeChange(
      {
      required Function changeInFireContent, Function? onNullValue,
      required String subscriberId,
      required String seriesId,
      required String objectId}) async {


    DatabaseReference starCountRef = _database.child(
        'EnrichTv/${StringConstants.subscriber}/$subscriberId/$subscriberId/${StringConstants.pathContent}/$seriesId/${StringConstants.episodes}/$objectId');


    starCountRef.onValue.listen((DatabaseEvent event) {
      final response = event.snapshot.value;

      if (response != null) {
        try {
          FireDatum fireContent =
              FireDatum.fromSnapshot(response as Map<dynamic, dynamic>);
          changeInFireContent(fireContent);
        } catch (e) {
          if (kDebugMode) {
            print("Fetching content");
            print(e.toString());
          }
        }
      }else if(onNullValue!=null){
        onNullValue();
      }
    });
  }


  listenForAContentChange(
      {
      required Function changeInFireContent, Function? onNullValue,
      required String subscriberId,
      required String objectId}) async {

    DatabaseReference starCountRef = _database.child(
        'EnrichTv/${StringConstants.subscriber}/$subscriberId/$subscriberId/${StringConstants.pathContent}/$objectId');

    starCountRef.onValue.listen((DatabaseEvent event) {
      final response = event.snapshot.value;

      if (response != null) {
        try {
          FireDatum fireContent =
              FireDatum.fromSnapshot(response as Map<dynamic, dynamic>);
          changeInFireContent(fireContent);
        } catch (e) {
          if (kDebugMode) {
            print("Fetching content");
            print(e.toString());
          }
        }
      }else if(onNullValue!=null){
        onNullValue();
      }
    });
  }

  listenForAContentLikeStatus(
      {required Function changeInFireContent,
      required String subscriberId,
      required String objectId}) async {
    DatabaseReference starCountRef = _database.child(
        'EnrichTv/${StringConstants.subscriber}/$subscriberId/$subscriberId/${StringConstants.pathContent}/$objectId/${FirebaseConstants.likeStatus}');

    starCountRef.onValue.listen((DatabaseEvent event) {
      final response = event.snapshot.value;

      if (response != null) {
        changeInFireContent(response);
      }
    });
  }

  listenForInWatchList(
      {required Function changeInFireContent,
         Function? onNullValue,
      required String subscriberId,
      required String objectId}) async {
    DatabaseReference starCountRef = _database.child(
        'EnrichTv/${StringConstants.subscriber}/$subscriberId/$subscriberId/${StringConstants.pathContent}/$objectId/${FirebaseConstants.inwatchlist}');

    starCountRef.onValue.listen((DatabaseEvent event) {
      final response = event.snapshot.value;

      if (response != null) {
        changeInFireContent(response);
      }
    });
  }

  removeContentNode(String objectid) async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String? subscriberData =
        sharedPreferences.getString(DeviceStorage.subscriberData);

    if (subscriberData == null || subscriberData == "") {
      return null;
    } else {
      SubscriberModel subscriberModel =
          SubscriberModel.fromJson(subscriberData);

      var subscriberId = subscriberModel.subscriberId;
      DatabaseReference databaseRef = _database.child(
          'EnrichTv/${StringConstants.subscriber}/$subscriberId/$subscriberId/${StringConstants.pathContent}/$objectid');
      databaseRef.remove();
    }
  }
}
