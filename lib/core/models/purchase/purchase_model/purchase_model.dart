import 'dart:convert';

import 'datum.dart';

class PurchaseModel {
  int? totalcount;
  List<Datum>? data;

  PurchaseModel({this.totalcount, this.data});

  @override
  String toString() => 'PurchaseModel(totalcount: $totalcount, data: $data)';

  factory PurchaseModel.fromMap(Map<String, dynamic> data) => PurchaseModel(
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
  /// Parses the string and returns the resulting Json object as [PurchaseModel].
  factory PurchaseModel.fromJson(String data) {
    return PurchaseModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PurchaseModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
