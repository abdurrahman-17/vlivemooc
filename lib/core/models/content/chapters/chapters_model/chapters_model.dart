import 'dart:convert';

import 'datum.dart';

class ChaptersModel {
  int? totalcount;
  List<ChapterDatum>? data;

  ChaptersModel({this.totalcount, this.data});

  @override
  String toString() => 'ChaptersModel(totalcount: $totalcount, data: $data)';

  factory ChaptersModel.fromMap(Map<String, dynamic> data) => ChaptersModel(
        totalcount: data['totalcount'] as int?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => ChapterDatum.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'totalcount': totalcount,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChaptersModel].
  factory ChaptersModel.fromJson(String data) {
    return ChaptersModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChaptersModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
