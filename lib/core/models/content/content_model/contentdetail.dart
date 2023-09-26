import 'dart:convert';

class Contentdetail {
  String? packageid;
  String? quality;
  String? streamtype;
  int? clearlead;
  List<dynamic>? drmscheme;
  List<dynamic>? availabilityset;
  dynamic subtitlelang;
  List<dynamic>? audiolang;

  Contentdetail({
    this.packageid,
    this.quality,
    this.streamtype,
    this.drmscheme,
    this.availabilityset,
    this.subtitlelang,
    this.audiolang,
    this.clearlead,
  });

  @override
  String toString() {
    return 'Contentdetail(packageid: $packageid, quality: $quality, streamtype: $streamtype,clearlead: $clearlead, drmscheme: $drmscheme, availabilityset: $availabilityset, subtitlelang: $subtitlelang, audiolang: $audiolang)';
  }

  factory Contentdetail.fromMap(Map<String, dynamic> data) => Contentdetail(
        packageid: data['packageid'] as String?,
        quality: data['quality'] as String?,
        streamtype: data['streamtype'] as String?,
        drmscheme: data['drmscheme'] as List<dynamic>?,
        availabilityset: data['availabilityset'] as List<dynamic>?,
        subtitlelang: data['subtitlelang'] as dynamic,
        audiolang: data['audiolang'] as List<dynamic>?,
        clearlead: data['clearlead'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'packageid': packageid,
        'quality': quality,
        'streamtype': streamtype,
        'drmscheme': drmscheme,
        'availabilityset': availabilityset,
        'subtitlelang': subtitlelang,
        'audiolang': audiolang,
        'clearlead': clearlead,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Contentdetail].
  factory Contentdetail.fromJson(String data) {
    return Contentdetail.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Contentdetail] to a JSON string.
  String toJson() => json.encode(toMap());
}
