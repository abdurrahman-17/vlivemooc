import 'dart:convert';

class Scrubbing {
  String? total;
  String? column;
  String? row;
  String? interval;
  String? filename;
  String? seekThumbnailImagePath;
  String? width;
  String? height;

  Scrubbing({
    this.total,
    this.column,
    this.row,
    this.interval,
    this.filename,
    this.seekThumbnailImagePath,
    this.width,
    this.height,
  });

  @override
  String toString() {
    return 'Scrubbing(total: $total, column: $column, row: $row, interval: $interval, filename: $filename, seekThumbnailImagePath: $seekThumbnailImagePath, width: $width, height: $height)';
  }

  factory Scrubbing.fromMap(Map<String, dynamic> data) => Scrubbing(
        total: data['total'] as String?,
        column: data['column'] as String?,
        row: data['row'] as String?,
        interval: data['interval'] as String?,
        filename: data['filename'] as String?,
        seekThumbnailImagePath: data['seekThumbnailImagePath'] as String?,
        width: data['width'] as String?,
        height: data['height'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'total': total,
        'column': column,
        'row': row,
        'interval': interval,
        'filename': filename,
        'seekThumbnailImagePath': seekThumbnailImagePath,
        'width': width,
        'height': height,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Scrubbing].
  factory Scrubbing.fromJson(String data) {
    return Scrubbing.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Scrubbing] to a JSON string.
  String toJson() => json.encode(toMap());
}
