import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';

import '../../models/content/content_model/datum.dart';

class TrailerPlayer extends StatefulWidget {
  final Datum content;
  final Function onTap;
  const TrailerPlayer({super.key, required this.content, required this.onTap});

  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  late VideoPlayerController _controller;
  bool shouldRender = false;
  @override
  void initState() {
    super.initState();
    String playUrl = widget.content.trailer;
    if (playUrl.isEmpty) {
      playUrl =
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
    }
    _controller = VideoPlayerController.networkUrl(Uri.parse(playUrl))
      ..initialize().then((_) {
        if (!mounted) {
          return;
        }
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.setVolume(0);
    if (!mounted) return;
    setState(() {});
    Timer(const Duration(milliseconds: 500), () {
      _controller.play();
      if (!mounted) {
        return;
      }
      setState(() {
        _controller.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const LoadingAnimation(
        width: 50,
      );
    }
    return InkWell(
        onTap: () {
          widget.onTap();
        },
        child: VideoPlayer(_controller));
     //return Container();
  }
}
