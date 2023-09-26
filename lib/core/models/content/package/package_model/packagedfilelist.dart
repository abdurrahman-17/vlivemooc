import 'dart:convert';

import 'audio.dart';
import 'scrubbing.dart';
import 'video.dart';

class Packagedfilelist {
  List<Video>? video;
  List<Audio>? audio;
  List<Scrubbing>? scrubbing;

  Packagedfilelist({this.video, this.audio, this.scrubbing});

  @override
  String toString() {
    return 'Packagedfilelist(video: $video, audio: $audio, scrubbing: $scrubbing)';
  }

  factory Packagedfilelist.fromMap(Map<String, dynamic> data) {
    return Packagedfilelist(
      video: (data['video'] as List<dynamic>?)
          ?.map((e) => Video.fromMap(e as Map<String, dynamic>))
          .toList(),
      audio: (data['audio'] as List<dynamic>?)
          ?.map((e) => Audio.fromMap(e as Map<String, dynamic>))
          .toList(),
      scrubbing: (data['scrubbing'] as List<dynamic>?)
          ?.map((e) => Scrubbing.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'video': video?.map((e) => e.toMap()).toList(),
        'audio': audio?.map((e) => e.toMap()).toList(),
        'scrubbing': scrubbing?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Packagedfilelist].
  factory Packagedfilelist.fromJson(String data) {
    return Packagedfilelist.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Packagedfilelist] to a JSON string.
  String toJson() => json.encode(toMap());
}
