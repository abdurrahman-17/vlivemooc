import 'dart:convert';

import 'filelist.dart';

class Poster {
  String? posterid;
  String? title;
  String? postertype;
  String? quality;
  List<Filelist>? filelist;
  String? pgrating;
  String? posterlanguage;
  List<String>? postertags;

  Poster({
    this.posterid,
    this.title,
    this.postertype,
    this.quality,
    this.filelist,
    this.pgrating,
    this.posterlanguage,
    this.postertags,
  });

  @override
  String toString() {
    return 'Poster(posterid: $posterid, title: $title, postertype: $postertype, quality: $quality, filelist: $filelist, pgrating: $pgrating,postertags: $postertags, posterlanguage: $posterlanguage)';
  }

  factory Poster.fromMap(Map<dynamic, dynamic> data) => Poster(
        posterid: data['posterid'] as String?,
        title: data['title'] as String?,
        postertype: data['postertype'] as String?,
        quality: data['quality'] as String?,
        filelist: (data['filelist'] as List<dynamic>?)
            ?.map((e) => Filelist.fromMap(e as Map<dynamic, dynamic>))
            .toList(),
        pgrating: data['pgrating'] as String?,
        posterlanguage: data['posterlanguage'] as String?,
        postertags: data['postertags'] != null
            ? List<String>.from(data['postertags'])
            : null,
      );

  Map<String, dynamic> toMap() => {
        'posterid': posterid,
        'title': title,
        'postertype': postertype,
        'quality': quality,
        'filelist': filelist?.map((e) => e.toMap()).toList(),
        'pgrating': pgrating,
        'posterlanguage': posterlanguage,
        'postergenre': postertags,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Poster].
  factory Poster.fromJson(String data) {
    return Poster.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Poster] to a JSON string.
  String toJson() => json.encode(toMap());
}
