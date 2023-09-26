import 'dart:convert';

import 'datum.dart';

class ContentModel {
  static const String course = "COURSE";
  static const String tvshow = "TVSHOW";
  static const String series = "SERIES";
  static const String content = "CONTENT";
  int? totalcount;
  List<Datum>? data;

  ContentModel({this.totalcount, this.data});

  @override
  String toString() => 'ContentModel(totalcount: $totalcount, data: $data)';

  factory ContentModel.fromMap(Map<String, dynamic> data) {
    List<Datum>? filter = (data['data'] as List<dynamic>?)
        ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
        .toList();
    List<Datum> filteredData = filter!
        .where(
          (element) =>
              element.poster != null && element.poster![0].filelist != null,
        )
        .toList();

    return ContentModel(
      totalcount: data['totalcount'] as int?,
      data: filteredData,
    );
  }

  Map<String, dynamic> toMap() => {
        'totalcount': totalcount,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ContentModel].
  factory ContentModel.fromJson(String data) {
    return ContentModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ContentModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
