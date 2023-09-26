import 'dart:convert';

class Details {
  List<dynamic>? cast;
  List<dynamic>? crew;

  Details({this.cast, this.crew});

  @override
  String toString() => 'Details(cast: $cast, crew: $crew)';

  factory Details.fromMap(Map<String, dynamic> data) => Details(
        cast: data['cast'] as List<dynamic>?,
        crew: data['crew'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'cast': cast,
        'crew': crew,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Details].
  factory Details.fromJson(String data) {
    return Details.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Details] to a JSON string.
  String toJson() => json.encode(toMap());
}
