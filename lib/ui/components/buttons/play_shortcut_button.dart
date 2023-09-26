import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';

import '../../../core/helpers/play_state.dart';
import '../../../core/models/content/chapters/chapters_model/chapters_model.dart';
import '../../../core/network/network_handler.dart';
import '../../../core/player/play_button_state.dart';
import '../../../core/player/play_service.dart';
import '../../constants/colors.dart';

class PlayShortcutButton extends StatefulWidget {
  final Datum content;
  final bool isSeries;

  const PlayShortcutButton(
      {super.key, required this.content, this.isSeries = false});

  @override
  State<PlayShortcutButton> createState() => _PlayShortcutButtonState();
}

class _PlayShortcutButtonState extends State<PlayShortcutButton> {
  late PlayState playState;
  bool playStateInitialized = false;
  late Datum content;

  @override
  void initState() {
    super.initState();
    content = widget.content;
    playState = PlayState(buttonState: "   ", isLoading: false);

  }

  getPlayState() async {
    String buttonState = await PlayButtonState().getState(content);
    PlayState state = PlayState(buttonState: buttonState, isLoading: false);
    setState(() {
      playState = state;
    });
  }

  onPlay({required callback}) async {
    if (!playStateInitialized) {
      if (widget.isSeries) {
        ChaptersModel chaptersModel = await NetworkHandler.getChapters(
            seriesid: widget.content.objectid, seasonnum: "1");
        setState(() {
          content = Datum.fromJson(chaptersModel.data![0].toJson());
        });
      }

      await getPlayState();
      setState(() {
        playStateInitialized = true;
      });
    }

    callback();
  }

  startPlayer(BuildContext context) async {
    PlayService playService = PlayService();
    playService.onPlayClick(
        context: context,
        playState: playState,
        content: content,
        onLoadCallback: (PlayState state, {String playerUrl = ""}) {
          setState(() {
            playState = state;
          });
          if (playerUrl.isNotEmpty) {
            playService.showWebPlayer(context, playerUrl, content);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return playState.isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ))
        : IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              onPlay(callback: () {
                startPlayer(context);
              });
            },
            icon: Icon(
              Icons.play_circle,
              color: AppColors.primaryColor,
              size: 30,
            ));
  }
}
