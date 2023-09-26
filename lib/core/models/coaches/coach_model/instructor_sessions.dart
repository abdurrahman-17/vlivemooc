import 'dart:convert';

import 'session_datum.dart';

class InstructorSessions {
  int? totalCount;
  List<SessionDatum>? sessionData;

  InstructorSessions({this.totalCount, this.sessionData});

  @override
  String toString() {
    return 'InstructorSessions(totalCount: $totalCount, sessionData: $sessionData)';
  }

  factory InstructorSessions.fromMap(Map<String, dynamic> data) {
    return InstructorSessions(
      totalCount: data['totalCount'] as int?,
      sessionData: (data['sessionData'] as List<dynamic>?)
          ?.map((e) => SessionDatum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'sessionData': sessionData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [InstructorSessions].
  factory InstructorSessions.fromJson(String data) {
    return InstructorSessions.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [InstructorSessions] to a JSON string.
  String toJson() => json.encode(toMap());
}
