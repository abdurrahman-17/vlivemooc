import 'dart:convert';

class Video {
  String? filename;
  String? quality;
  String? duration;
  String? size;

  Video({this.filename, this.quality, this.duration, this.size});

  @override
  String toString() {
    return 'Video(filename: $filename, quality: $quality, duration: $duration, size: $size)';
  }

  factory Video.fromMap(Map<String, dynamic> data) => Video(
        filename: data['filename'] as String?,
        quality: data['quality'] as String?,
        duration: data['duration'] as String?,
        size: data['size'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'filename': filename,
        'quality': quality,
        'duration': duration,
        'size': size,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Video].
  factory Video.fromJson(String data) {
    return Video.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Video] to a JSON string.
  String toJson() => json.encode(toMap());
}
