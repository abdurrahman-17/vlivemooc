import 'dart:convert';

import 'datum.dart';

class PlansModel {
  int? totalcount;
  List<Datum>? data;

  PlansModel({this.totalcount, this.data});

  @override
  String toString() => 'PlansModel(totalcount: $totalcount, data: $data)';

  factory PlansModel.fromMap(Map<String, dynamic> data) => PlansModel(
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
  /// Parses the string and returns the resulting Json object as [PlansModel].
  factory PlansModel.fromJson(String data) {
    return PlansModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PlansModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
