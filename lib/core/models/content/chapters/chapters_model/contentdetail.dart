import 'dart:convert';

class Contentdetail {
  String? packageid;
  String? quality;
  String? streamtype;
  List<dynamic>? drmscheme;
  String? mediatype;
  List<dynamic>? availabilityset;
  dynamic subtitlelang;
  List<dynamic>? audiolang;

  Contentdetail({
    this.packageid,
    this.quality,
    this.streamtype,
    this.drmscheme,
    this.mediatype,
    this.availabilityset,
    this.subtitlelang,
    this.audiolang,
  });

  @override
  String toString() {
    return 'Contentdetail(packageid: $packageid, quality: $quality, streamtype: $streamtype, drmscheme: $drmscheme, mediatype: $mediatype, availabilityset: $availabilityset, subtitlelang: $subtitlelang, audiolang: $audiolang)';
  }

  factory Contentdetail.fromMap(Map<String, dynamic> data) => Contentdetail(
        packageid: data['packageid'] as String?,
        quality: data['quality'] as String?,
        streamtype: data['streamtype'] as String?,
        drmscheme: data['drmscheme'] as List<dynamic>?,
        mediatype: data['mediatype'] as String?,
        availabilityset: data['availabilityset'] as List<dynamic>?,
        subtitlelang: data['subtitlelang'] as dynamic,
        audiolang: data['audiolang'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'packageid': packageid,
        'quality': quality,
        'streamtype': streamtype,
        'drmscheme': drmscheme,
        'mediatype': mediatype,
        'availabilityset': availabilityset,
        'subtitlelang': subtitlelang,
        'audiolang': audiolang,
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
