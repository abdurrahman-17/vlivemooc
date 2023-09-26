import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/models/content/chapters/chapters_model/datum.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/content/modules/modules_model/datum.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/player/play_service.dart';

import '../../ui/routes/Routes.dart';
import '../models/content/chapters/chapters_model/chapters_model.dart';
import '../models/content/content_model/content_model.dart';
import '../models/content/package/package_model/package_model.dart';
import '../player/play_button_state.dart';

const playerChannel = MethodChannel('com.mobiotics.androidplayer');
const relatedContentsChannel =
    MethodChannel('com.mobiotics.playerRelatedContent');


setPlayerReleaseHandler(BuildContext context) async {
  playerChannel.setMethodCallHandler((call) async {
    if (call.method == 'updateWatchedPercentage') {
      var status = call.arguments["status"] as String?;
      var watchedDurationInSec = call.arguments["watchedDuration"] as int?;
      if (kDebugMode) {
        print("watchedDurationInSec $watchedDurationInSec");
        print("this is parsed ${call.arguments['content']}");
      }

      Datum? playedContent =
          Datum.fromMap(jsonDecode(call.arguments["content"] as String));
      // Handle the received data as needed, we make sure the data is not null.
      if (watchedDurationInSec != null && status != null) {
        firebaseActions.addInContinueWatching(
            playedContent, context, watchedDurationInSec, status, () {
          context.go('/${AppRouter.login}');
        });
      }
    }
    else if (call.method == 'related') {
      //THis is to get the related content for the currently playing video
      var objectid = call.arguments;
      if (objectid != null) {
        List<Datum> relatedContents =
            await getRelatedContentAndSendToPlayer(objectid);
        var json = (relatedContents.map((e) => e.toJson()).toList());
        await relatedContentsChannel.invokeMethod(
            "relatedContent", json.toString());
      }
    }
    else if (call.method == 'playRelatedContent') {
      //This is to get the related content for the currently playing video android.

      Datum? contentToPlay = Datum.fromJson(call.arguments["content"]);
      playRelatedContent(contentToPlay: contentToPlay);

    }else if (call.method == 'episodes') {
      //This is to get the related content for the currently playing video android.

      Datum? contentToPlay = Datum.fromJson(call.arguments["content"]);
      getSeasonsAndEpisodes(contentToPlay: contentToPlay);

    }
  });
}

/// Get modules and chapters for the player to play the contents
void getSeasonsAndEpisodes({required Datum contentToPlay}) {
  NetworkHandler.getModules(seriesid: contentToPlay.seriesid).then((modulesModel) async{
    if((modulesModel.totalcount??0)>0){
     List<ModuleDatum> modules=modulesModel.data!;
     Map<int,List<ChapterDatum>> chapters= {};
     //Fetch Episodes for all modules
     for (ModuleDatum element in modules) {
       ChaptersModel chaptersModel =await NetworkHandler.getChapters(seriesid: contentToPlay.seriesid, seasonnum: element.seasonnum.toString());
       chapters[element.seasonnum??1]=chaptersModel.data! ;
     }

     Map<String, dynamic> seasonsEpisodes ={};

     seasonsEpisodes["Seasons"]=(modules.map((e) => e.toJson()).toList()).toString();
     seasonsEpisodes["Episodes"] = chapters.map((key, value) => MapEntry(
         key.toString(), value.map((content) => content.toJson()).toList())).toString();

     relatedContentsChannel.invokeMethod("SeasonsEpisodes", seasonsEpisodes);

    }
  }
  );

}

void playRelatedContent({required Datum contentToPlay}) async {
  contentToPlay = await NetworkHandler.getContentDetail(contentToPlay.objectid);
  String buttonState = await PlayButtonState().getState(contentToPlay);

  if (buttonState == PlayButtonState.play) {
    PackageModel packageModel = await NetworkHandler.getPackageDetail(contentToPlay);


    Map<String, dynamic> playerParams =
        await PlayService().generateAndroidParams(contentToPlay, packageModel);
    relatedContentsChannel.invokeMethod("playRelatedContent", playerParams);
  } else {
    //Conditions need to handle
  }
}

Future<List<Datum>> getRelatedContentAndSendToPlayer(String objectid) async {
  try {
    ContentModel model =
        await NetworkHandler.getRelatedContent(contentid: objectid);
    if ((model.totalcount ?? 0) > 0) {
      return model.data!;
    } else {
      return List<Datum>.empty();
    }
  } catch (error) {
    if (kDebugMode) {
      print(error.toString());
    }
    return List<Datum>.empty();
  }
}
