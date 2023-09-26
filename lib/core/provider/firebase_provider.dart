import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';

import '../models/content/chapters/chapters_model/chapters_model.dart';
import '../models/content/chapters/chapters_model/datum.dart';
import '../models/content/modules/modules_model/modules_model.dart';
import '../models/firebase/fire_datum.dart';
import '../network/network_handler.dart';

class FirebaseProvider with ChangeNotifier {
  void fetchContentFromFirebase(
      Datum content, BuildContext context, Function onFetchContinueWatching,
      {Function? onNullValue}) {

    UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoggedIn) {
      if(content.episodenum!=null){
        fetchEpisodeFromFirebase(content, context, onFetchContinueWatching,onNullValue: onNullValue);
      }else{
        //Fetch subscriber and then get the fire contents
        firebaseRealtimeDatabase.listenForAContentChange(
            changeInFireContent: onFetchContinueWatching,
            subscriberId: userProvider.subscriberModel!.subscriberId,
            objectId: content.objectid,
            onNullValue: onNullValue);
      }

    }
  }

  void fetchEpisodeFromFirebase(
      Datum content, BuildContext context, Function onFetchContinueWatching,
      {Function? onNullValue}) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoggedIn) {
      //Fetch subscriber and then get the fire contents
      firebaseRealtimeDatabase.listenForEpisodeChange(
          changeInFireContent: onFetchContinueWatching,
          subscriberId: userProvider.subscriberModel!.subscriberId,
          seriesId: content.seriesid,
          objectId: content.objectid,
          onNullValue: onNullValue);
    }
  }

  getFireEpisodeToPlay(FireDatum fireContent) {
    //Resume the content if it is not course
    if (fireContent.objecttype == ContentModel.series) {
      List<FireEpisode>? episodes = fireContent.getEpisodesList();
      episodes.sort((c1, c2) => c1.updatedAt.compareTo(c2.updatedAt));
      episodes = episodes.reversed.toList();
      return episodes.first;
    }
  }

  //Here first we get modules
  //THen fetch chapters in which the episode is there from particular season
  //Assigning the content object to it
  //then return the content object.
  //
  Future<Datum?> getChapterToPlay(
      FireEpisode? fireEpisodeToPlay, Datum content) async {
    ModulesModel slugModules =
        await NetworkHandler.getModules(seriesid: content.objectid);
    if (slugModules.data != null) {
      slugModules.data
          ?.sort((c1, c2) => c1.seasonnum!.compareTo(c2.seasonnum!));

      ChaptersModel chaptersModel = await NetworkHandler.getChapters(
          seriesid: content.objectid,
          seasonnum: fireEpisodeToPlay == null
              ? slugModules.data!.first.seasonnum!.toString()
              : fireEpisodeToPlay.seasonnum.toString());

      if (fireEpisodeToPlay != null) {
        ChapterDatum? chapterToPlay = chaptersModel.data?.firstWhere(
            (element) => fireEpisodeToPlay.objectid == element.objectid);
        if (chapterToPlay != null) {
          content = Datum.fromJson(chapterToPlay.toJson());
          content.watchedDuration = fireEpisodeToPlay.watchedDuration;
          return content;
        }
      }

      return Datum.fromJson(chaptersModel.data![0].toJson());
    }

    return null;
  }
}
