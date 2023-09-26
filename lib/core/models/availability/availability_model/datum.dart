import 'dart:convert';

class Datum {
  String? availabilityid;
  String? availabilityname;
  List<dynamic>? country;
  dynamic exclusionlist;
  List<dynamic>? devicetypelist;
  String? pricemodel;
  String? quality;
  dynamic regionlist;
  int? licenseduration;
  String? accesstype;
  dynamic description;
  dynamic adcueid;

  Datum({
    this.availabilityid,
    this.availabilityname,
    this.country,
    this.exclusionlist,
    this.devicetypelist,
    this.pricemodel,
    this.quality,
    this.regionlist,
    this.licenseduration,
    this.accesstype,
    this.description,
    this.adcueid,
  });

  @override
  String toString() {
    return 'Datum(availabilityid: $availabilityid, availabilityname: $availabilityname, country: $country, exclusionlist: $exclusionlist, devicetypelist: $devicetypelist, pricemodel: $pricemodel, quality: $quality, regionlist: $regionlist, licenseduration: $licenseduration, accesstype: $accesstype, description: $description, adcueid: $adcueid)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        availabilityid: data['availabilityid'] as String?,
        availabilityname: data['availabilityname'] as String?,
        country: data['country'] as List<dynamic>?,
        exclusionlist: data['exclusionlist'] as dynamic,
        devicetypelist: data['devicetypelist'] as List<dynamic>?,
        pricemodel: data['pricemodel'] as String?,
        quality: data['quality'] as String?,
        regionlist: data['regionlist'] as dynamic,
        licenseduration: data['licenseduration'] as int?,
        accesstype: data['accesstype'] as String?,
        description: data['description'] as dynamic,
        adcueid: data['adcueid'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'availabilityid': availabilityid,
        'availabilityname': availabilityname,
        'country': country,
        'exclusionlist': exclusionlist,
        'devicetypelist': devicetypelist,
        'pricemodel': pricemodel,
        'quality': quality,
        'regionlist': regionlist,
        'licenseduration': licenseduration,
        'accesstype': accesstype,
        'description': description,
        'adcueid': adcueid,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());
}
