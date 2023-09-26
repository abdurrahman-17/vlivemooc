import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/buttons/play_button.dart';

import '../../../core/helpers/play_state.dart';
import '../../../core/models/content/content_model/datum.dart';


class PlayFloatingButton extends StatefulWidget {
  final Datum content;
  final bool isCourse;
  const PlayFloatingButton(
      {super.key, required this.content, this.isCourse = false});

  @override
  State<PlayFloatingButton> createState() => _PlayFloatingButtonState();
}

class _PlayFloatingButtonState extends State<PlayFloatingButton> {
  @override
  Widget build(BuildContext context) {

    return  PlayButton(content: widget.content, isCourse: widget.isCourse, renderType: PlayState.shortcutButton,);
  }
}
