import 'package:flutter/widgets.dart';

import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/core/player/play_service.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../ui/components/dialogs/pogress_dialog.dart';
import '../helpers/play_state.dart';
import '../models/content/content_model/datum.dart';
import '../models/content/modules/modules_model/datum.dart';
import '../network/network_handler.dart';
import '../player/play_button_state.dart';

FireContentService fireContentService= FireContentService();

class FireContentService  {

  showProgressBarAfterFireContentClick(FireDatum fireContent, BuildContext context,Function removePopup){
    showProgressDialog(context);
     fireContentService.performTasksOnClick(
        fireContent, context,
         removePopup:removePopup);
  }

  performTasksOnClick(FireDatum fireContent, BuildContext context,{required Function removePopup})  {
      //Fetch the content details to play
    if(fireContent.objecttype==ContentModel.content)
      {
        NetworkHandler.getContentDetail(fireContent.objectid).then((contentToPlay) {
          if (contentToPlay.objecttype == StringConstants.content) {
            if (fireContent.watchedDuration != null) {
              contentToPlay.watchedDuration = fireContent.watchedDuration??1;
              getPlayState(contentToPlay).then((value) {
                PlayService playService = PlayService();
                playService.onPlayClick(context: context, playState: value, content: contentToPlay, onLoadCallback:(PlayState state, {String playerUrl = ""}) {
                  if(!state.isLoading)
                    {
                      removePopup();
                    }

                  if (playerUrl.isNotEmpty) {
                    playService.showWebPlayer(context, playerUrl, contentToPlay);
                  }
                }
                );
              });
            }
          }
        });
      }else {
      //Fetch the seasons&episodes and pass as an array
      fetchSeasonsAndEpisodes(context,fireContent: fireContent,removePopup:removePopup);
    }

  }

  Future<PlayState> getPlayState(Datum datum) async {
    String buttonState = await PlayButtonState().getState(datum);
    PlayState state = PlayState(buttonState: buttonState, isLoading: false);
    return   state;
  }

  fetchSeasonsAndEpisodes(BuildContext context,
      {required FireDatum fireContent,required Function removePopup}) {


    if (fireContent.episodes != null) {
      List<FireEpisode> fireEpisodes = fireContent.getEpisodesList();
      fireEpisodes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      FireEpisode episodeToPlay=fireEpisodes.first;
      NetworkHandler.getContentDetail(episodeToPlay.objectid).then((contentToPlay) {
          contentToPlay.watchedDuration = episodeToPlay.watchedDuration;
          getPlayState(contentToPlay).then((value) {
            PlayService playService = PlayService();
            playService.onPlayClick(context: context, playState: value, content: contentToPlay, onLoadCallback:(PlayState state, {String playerUrl = ""}) {
              if(!state.isLoading)
              {
                removePopup();
              }

              if (playerUrl.isNotEmpty) {
                playService.showWebPlayer(context, playerUrl, contentToPlay);
              }
            }
            );
          });

      });
      return;
    }else{
      List<ModuleDatum> seasonsList = [];
        //Get te modules/Seasom. Get 1st episode and play
      NetworkHandler.getModules(seriesid: fireContent.objectid).then((
          slugModules)  {
        seasonsList = slugModules.data!;
        seasonsList.sort((c1, c2) => c1.seasonnum!.compareTo(c2.seasonnum!));
        //-----------------------
        //Get Episodes/chapters from modules
        for (var i = 0; i < 1; i++) {
          NetworkHandler.getChapters(
              seriesid: fireContent.objectid,
              seasonnum: (seasonsList[i].seasonnum).toString()).then((slugChapter){

            slugChapter.data?.sort((c1, c2) => c1.episodenum!.compareTo(c2.episodenum!));

            NetworkHandler.getContentDetail(slugChapter.data!.first.objectid!).then((contentToPlay) {
                getPlayState(contentToPlay).then((value) {
                  PlayService playService = PlayService();
                  playService.onPlayClick(context: context, playState: value, content: contentToPlay, onLoadCallback:(PlayState state, {String playerUrl = ""}) {
                    if (playerUrl.isNotEmpty) {
                      playService.showWebPlayer(context, playerUrl, contentToPlay);
                    }
                  }
                  ).then((value) {
                    removePopup();
                  });
                });


            });

          });
        }


      });

    }

  }

}
