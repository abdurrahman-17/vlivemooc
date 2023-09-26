import 'dart:convert';

import 'response.dart';

class EventsModel {
  int? totalCount;
  List<Response>? response;

  EventsModel({this.totalCount, this.response});

  @override
  String toString() {
    return 'EventsModel(totalCount: $totalCount, response: $response)';
  }

  factory EventsModel.fromMap(Map<String, dynamic> data) => EventsModel(
        totalCount: data['totalCount'] as int?,
        response: (data['response']['data'] as List<dynamic>?)
            ?.map((e) => Response.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'response': response?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EventsModel].
  factory EventsModel.fromJson(String data) {
    return EventsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EventsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
