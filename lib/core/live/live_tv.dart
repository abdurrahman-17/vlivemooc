import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vlivemooc/core/helpers/play_state.dart';
import 'package:vlivemooc/core/models/content/package/package_model/package_model.dart';
import 'package:vlivemooc/core/player/play_button_state.dart';

import '../models/content/content_model/datum.dart';
import '../player/play_service.dart';

class LiveTV {
  var contentStream = {
    "drmscheme": ["NONE"],
    "packageid": "123Da9rZiFKVtfPj",
    "quality": "HD",
    "streamfilename":
        "https://enrichtv.pc.cdn.bitgravity.com/enrichtv/live/amlst:testfeed_,b144,b288,b576,b720,.smil/playlist.m3u8",
    "streammode": "VOD",
    "streamtype": "HLS"
  };

  var liveTvContent = {
    "category": "LIVE",
    "contentlanguage": ["ENG"],
    "contentdetails": [
      {
        "packageid": "123Da9rZiFKVtfPj",
        "quality": "HD",
        "streamtype": "DASH",
        "drmscheme": ["NONE"],
        "availabilityset": ["VFS0ETQL"],
        "subtitlelang": null,
        "audiolang": ["eng"]
      },
      {
        "packageid": "123uKfX3yvtvbLt1",
        "quality": "HD",
        "streamtype": "HLS",
        "drmscheme": ["NONE"],
        "availabilityset": ["VFS0ETQL"],
        "subtitlelang": null,
        "audiolang": ["eng"]
      }
    ],
    "defaultgenre": "BIOGRAPHY",
    "defaulttitle": "EnrichTV",
    "details": {"cast": [], "crew": []},
    "genre": "BIOGRAPHY",
    "isAdded": false,
    "isBlank": false,
    "isChecked": false,
    "isCurrentseries": false,
    "isTrailer": false,
    "itemlist": [],
    "longdescription":
        "Discover the power of transformation and spirituality with Andreea Tamas (USA) as she shares valuable life lessons. Embrace the unexpected and learn to adapt to change, as you journey towards a more fulfilling life.",
    "objecttype": "CHANEL",
    "objectid": "3RkCzvlS8ZLg",
    "objectstatus": "ACTIVE",
    "pgrating": "ALL",
    "poster": [
      {
        "filelist": [
          {
            "filename":
                "https://d1vjhjjegcy8qy.cloudfront.net/POSTER/77pih1o4oz_LANDSCAPE_HD.jpg",
            "quality": "HD"
          },
          {
            "filename":
                "https://d1vjhjjegcy8qy.cloudfront.net/POSTER/77pih1o4oz_LANDSCAPE_SD.jpg",
            "quality": "SD"
          },
          {
            "filename":
                "https://d1vjhjjegcy8qy.cloudfront.net/POSTER/77pih1o4oz_LANDSCAPE_LOW.jpg",
            "quality": "LOW"
          },
          {
            "filename":
                "https://d1vjhjjegcy8qy.cloudfront.net/POSTER/77pih1o4oz_LANDSCAPE_THUMBNAIL.jpg",
            "quality": "THUMBNAIL"
          }
        ],
        "pgrating": "ALL",
        "posterid": "77pih1o4oz",
        "postertype": "LANDSCAPE",
        "title": "Life_Via_5_Senses_Of_Perception_Sadhguru_Wellness_5_5_23.jpg"
      }
    ],
    "ratingtype": "NUMERIC",
    "shortdescription": "Discover the power of transformation",
    "tags": ["Wellness", "Personal Growth", "Women Empowernment"],
    "title": "Enrich TV",
    //  "trailer": [],
  };

  play(BuildContext context) async {
    const platform = MethodChannel("com.mobiotics.media");
    Datum content = Datum.fromMap(liveTvContent);
    PackageModel packageModel = PackageModel.fromMap(contentStream);
    if (kIsWeb) {
      var params = await PlayService().generateWebParams(content, packageModel,
          isDrm: false,
          isLive: true,
          playState:
              PlayState(buttonState: PlayButtonState.play, isLoading: false));
      String encodedString = jsonEncode(params);
      String playerUrl = "${Uri.base.origin}/player.html?data=$encodedString";
      // String playerUrl = "http://[::]:8080/?data=$encodedString";
// ignore: use_build_context_synchronously
      PlayService().showWebPlayer(context, playerUrl, content);

      //LinkLauncherWeb().launchUrlWeb(playerUrl);
    } else {
      Map<String, dynamic> playerParams = {};
      if (Platform.isAndroid) {
        playerParams =
            await PlayService().generateAndroidParams(content, packageModel);
      } else if (Platform.isIOS) {
        playerParams =
            await PlayService().generateiOSParams(content, packageModel);
      }
      try {
        await platform.invokeMethod("openPlayer", playerParams);
      } on PlatformException {
        //handle platfrom exception here
      }
    }
  }
}
