import 'dart:convert';

class Audio {
  String? filename;
  String? quality;
  String? language;
  String? duration;
  String? size;

  Audio({
    this.filename,
    this.quality,
    this.language,
    this.duration,
    this.size,
  });

  @override
  String toString() {
    return 'Audio(filename: $filename, quality: $quality, language: $language, duration: $duration, size: $size)';
  }

  factory Audio.fromMap(Map<String, dynamic> data) => Audio(
        filename: data['filename'] as String?,
        quality: data['quality'] as String?,
        language: data['language'] as String?,
        duration: data['duration'] as String?,
        size: data['size'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'filename': filename,
        'quality': quality,
        'language': language,
        'duration': duration,
        'size': size,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Audio].
  factory Audio.fromJson(String data) {
    return Audio.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Audio] to a JSON string.
  String toJson() => json.encode(toMap());
}
