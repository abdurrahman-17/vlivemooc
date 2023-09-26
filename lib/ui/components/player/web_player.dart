import "package:universal_html/html.dart";

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';
import 'package:vlivemooc/ui/components/popups/play_lead_popup.dart';
import 'dart:ui' as ui;

import '../../../core/fireabse/firebase_actions.dart';
import '../../../core/models/content/content_model/datum.dart';
import 'package:uuid/uuid.dart';

class WebPlayer extends StatefulWidget {
  final String playerUrl;
  final Datum content;
  final Function onClose;

  const WebPlayer(
      {super.key,
      required this.playerUrl,
      required this.onClose,
      required this.content});

  @override
  State<WebPlayer> createState() => _WebPlayerState();
}

class _WebPlayerState extends State<WebPlayer> {
  late Widget _iframeWidget;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("player url => ${widget.playerUrl}");
    }
    window.addEventListener("message", eventListener);

    final IFrameElement iframeElement = IFrameElement();
    iframeElement.style.height = '100%';
    iframeElement.style.width = '100%';
    iframeElement.src = widget.playerUrl;
    iframeElement.style.border = 'none';
    iframeElement.allow = "encrypted-media";
    iframeElement.allowFullscreen = true;
    String frameid = const Uuid().v4().toString();
// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      frameid,
      (int viewId) => iframeElement,
    );
    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: frameid,
    );
    toggleFullScreen(true);
  }

  toggleFullScreen(bool fullScreen) {
    if (fullScreen) {
      document.documentElement!.requestFullscreen();
    } else {
      document.exitFullscreen();
    }
  }

  eventListener(event) async {
    if (!mounted) {
      return;
    }
    var data = (event as MessageEvent).data ?? '-';
    if (data == '-') {
      return;
    }
    String eventType = "";
    try {
      eventType = data['type'];
    } catch (invalidEvent) {
      //event is invalid
      return;
    }
    switch (eventType) {
      case "close":
        toggleFullScreen(false);
        widget.onClose();
        break;
      case "continue_watch":
        if (!ProviderConstants.isLoggedIn) {
          return;
        }
        int position = data['position'];
        if (position == 0) {
          return;
        }
        //continue watch code here;
        int progressPercentage =
            ((position / (widget.content.duration ?? 1)) * 100).toInt();
        String status = progressPercentage > 95 ? "COMPLETED" : "INPROGRESS";

        if (widget.content.objecttype == ContentModel.content) {
          await firebaseActions.addInContinueWatching(
              widget.content, context, position, status, () {
            // context.go('/${AppRouter.login}');
          });
        }
        break;
      case "playlead_ended":
        try {
          widget.onClose();
        } catch (error) {
          //do nothing
        }
        PlayLeadPopup(context: context, content: widget.content).showPopup();
        break;

      case "on_fullscreen_change":
        bool fullScreen = data['fullscreen'];
        toggleFullScreen(fullScreen);

      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    window.removeEventListener("message", eventListener);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _iframeWidget,
      ),
    );
  }
}
