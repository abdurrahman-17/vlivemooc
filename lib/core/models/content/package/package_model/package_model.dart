import 'dart:convert';

import 'packagedfilelist.dart';

class PackageModel {
  String? packageid;
  String? quality;
  String? streamtype;
  String? streammode;
  List<dynamic>? drmscheme;
  int? clearlead;
  String? streamfilename;
  Packagedfilelist? packagedfilelist;

  PackageModel({
    this.packageid,
    this.quality,
    this.streamtype,
    this.streammode,
    this.drmscheme,
    this.streamfilename,
    this.packagedfilelist,
    this.clearlead,
  });

  @override
  String toString() {
    return 'PackageModel(packageid: $packageid, quality: $quality, streamtype: $streamtype, streammode: $streammode, drmscheme: $drmscheme, streamfilename: $streamfilename, packagedfilelist: $packagedfilelist)';
  }

  factory PackageModel.fromMap(Map<String, dynamic> data) => PackageModel(
        packageid: data['packageid'] as String?,
        quality: data['quality'] as String?,
        streamtype: data['streamtype'] as String?,
        streammode: data['streammode'] as String?,
        drmscheme: data['drmscheme'] as List<dynamic>?,
        streamfilename: data['streamfilename'] as String?,
        packagedfilelist: data['packagedfilelist'] == null
            ? null
            : Packagedfilelist.fromMap(
                data['packagedfilelist'] as Map<String, dynamic>),
        clearlead: data['clearlead'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'packageid': packageid,
        'quality': quality,
        'streamtype': streamtype,
        'streammode': streammode,
        'drmscheme': drmscheme,
        'streamfilename': streamfilename,
        'packagedfilelist': packagedfilelist?.toMap(),
        'clearlead': clearlead,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PackageModel].
  factory PackageModel.fromJson(String data) {
    return PackageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PackageModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
