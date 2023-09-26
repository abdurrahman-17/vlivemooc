import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/helpers/play_state.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/player/play_button_state.dart';
import 'package:vlivemooc/core/player/play_service.dart';
import 'package:vlivemooc/core/provider/firebase_provider.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';
import '../../../core/models/firebase/fire_datum.dart';
import '../../animations/loading_animation.dart';
import '../../constants/colors.dart';


class PlayButton extends StatefulWidget {
  final Datum content;
  final bool isCourse;
  final String buttonText;
  final String renderType;

  const PlayButton(
      {super.key,
      required this.content,
      this.isCourse = false,
      this.buttonText = "",
      this.renderType = PlayState.boxedButton
      });

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  late PlayState playState;
  Datum? content;
  FireDatum? fireDatum;

  @override
  void initState() {
    super.initState();
    content = widget.content;
    playState = PlayState(buttonState: "   ", isLoading: true);
  }

  FireEpisode? fireEpisodeToPlay;
  onFetchContinueWatching(FireDatum fireContent) {
    //Resume the content if it is not course
    fireEpisodeToPlay= firebaseProvider.getFireEpisodeToPlay(fireContent);
    setState(() {
      fireDatum = fireContent;
      if (!widget.isCourse ) {
        content?.watchedDuration = fireContent.watchedDuration ?? 1;
        if (content!.watchedDuration! > 1 ) {
          playState.buttonText = PlayButtonState.resume;
        }
      }
    });
    getPlayState();
  }

  getPlayState() async {
    if (widget.isCourse) {
    Datum? conTentToPlay= await firebaseProvider.getChapterToPlay(fireEpisodeToPlay,content!);
      setState(() {
        if(conTentToPlay!=null) {
          content = conTentToPlay;
        }
      });

      if(conTentToPlay==null){
        return;
      }
    }

    String buttonState = await PlayButtonState().getState(content!);
    bool disabled = false;
    if (buttonState == PlayButtonState.notAvailable) {
      disabled = true;
    }
    PlayState state = PlayState(
        buttonState: buttonState, isLoading: false, disabled: disabled);

    if (buttonState == PlayButtonState.clearLead) {
      state.buttonText = PlayButtonState().getClearLeadText(widget.content);
    } else {
      if (widget.buttonText.isNotEmpty) {
        if (buttonState == PlayButtonState.play) {
          state.buttonText = widget.buttonText;
        } else {
          state.buttonText = buttonState;
        }
      } else {
        state.buttonText = buttonState;
      }
    }

    //Resume the content if it is not course
    if (buttonState == PlayButtonState.play && !widget.isCourse) {
      content?.watchedDuration = fireDatum?.watchedDuration ?? 1;
      if (content!.watchedDuration! > 1 && !widget.isCourse) {
        state.buttonText = PlayButtonState.resume;
      }
    }

    setState(() {
      playState = state;
    });
  }

  onPlay() async {
    PlayService playService = PlayService();
    await playService.onPlayClick(
        context: context,
        playState: playState,
        content: content!,
        onLoadCallback: (PlayState state, {String playerUrl = ""}) {
          setState(() {
            playState = state;
          });
          if (playerUrl.isNotEmpty) {
            playService.showWebPlayer(context, playerUrl, content!);
          }
        });
  }


  late FirebaseProvider firebaseProvider;
  @override
  void didChangeDependencies() {
     firebaseProvider = Provider.of<FirebaseProvider>(context);
     firebaseProvider.fetchContentFromFirebase(widget.content, context, onFetchContinueWatching,onNullValue:getPlayState);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    if(widget.renderType == PlayState.boxedButton){
      return CircularLoadingElevatedButton(
        height: 40,
        onTap: () {
          onPlay();
        },
        isLoading: playState.isLoading,
        buttonText: playState.buttonText,
        disabled: playState.disabled,
      );
    }
    else {
      return FloatingActionButton(
        heroTag: UniqueKey().toString(),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryColor,
        onPressed: ()  {
         onPlay();
        },
        child: playState.isLoading
            ? const LoadingAnimation()
            : const Icon(Icons.play_arrow),
      );

    }


  }

}
