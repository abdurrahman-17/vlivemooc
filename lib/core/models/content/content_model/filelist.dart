import 'dart:convert';

class Filelist {
  String? quality;
  String? filename;
  String? format;

  Filelist({this.quality, this.filename, this.format});

  @override
  String toString() {
    return 'Filelist(quality: $quality, filename: $filename, format: $format)';
  }

  factory Filelist.fromMap(Map<dynamic, dynamic> data) => Filelist(
        quality: data['quality'] as String?,
        filename: data['filename'] as String?,
        format: data['format'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'quality': quality,
        'filename': filename,
        'format': format,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Filelist].
  factory Filelist.fromJson(String data) {
    return Filelist.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Filelist] to a JSON string.
  String toJson() => json.encode(toMap());
}
