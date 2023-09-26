import 'dart:convert';

import 'datum.dart';

class ModulesModel {
  int? totalcount;
  List<ModuleDatum>? data;

  ModulesModel({this.totalcount, this.data});

  @override
  String toString() => 'ModulesModel(totalcount: $totalcount, data: $data)';

  factory ModulesModel.fromMap(Map<String, dynamic> data) => ModulesModel(
        totalcount: data['totalcount'] as int?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => ModuleDatum.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'totalcount': totalcount,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ModulesModel].
  factory ModulesModel.fromJson(String data) {
    return ModulesModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ModulesModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
