import 'dart:convert';

import 'datum.dart';

class ProfileModel {
  int? totalcount;
  List<Datum>? data;

  ProfileModel({this.totalcount, this.data});

  @override
  String toString() => 'ProfileModel(totalcount: $totalcount, data: $data)';

  factory ProfileModel.fromMap(Map<String, dynamic> data) => ProfileModel(
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
  /// Parses the string and returns the resulting Json object as [ProfileModel].
  factory ProfileModel.fromJson(String data) {
    return ProfileModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProfileModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
