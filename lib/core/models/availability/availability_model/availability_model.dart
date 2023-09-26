import 'dart:convert';

import 'datum.dart';

class AvailabilityModel {
  int? totalcount;
  List<Datum>? data;

  AvailabilityModel({this.totalcount, this.data});

  @override
  String toString() {
    return 'AvailabilityModel(totalcount: $totalcount, data: $data)';
  }

  factory AvailabilityModel.fromMap(Map<String, dynamic> data) {
    return AvailabilityModel(
      totalcount: data['totalcount'] as int?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'totalcount': totalcount,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AvailabilityModel].
  factory AvailabilityModel.fromJson(String data) {
    return AvailabilityModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AvailabilityModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
