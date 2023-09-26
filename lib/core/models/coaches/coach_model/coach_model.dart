import 'dart:convert';

import 'datum.dart';

class CoachModel {
  int? totalcount;
  List<Datum>? data;

  CoachModel({this.totalcount, this.data});

  @override
  String toString() => 'CoachModel(totalcount: $totalcount, data: $data)';

  factory CoachModel.fromMap(Map<String, dynamic> data) => CoachModel(
        totalcount: data['totalcount'] as int?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'totalcount': totalcount,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CoachModel].
  factory CoachModel.fromJson(String data) {
    return CoachModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CoachModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
