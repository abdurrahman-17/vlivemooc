import 'dart:convert';

class Datum {
  String? partnerid;
  String? partnername;
  String? description;
  String? status;
  String? email;
  String? country;
  String? countryname;
  dynamic profilepicture;
  List<String>? tags;
  dynamic fburl;
  dynamic twitterurl;
  dynamic linkedinurl;
  String? partneradminid;
  DateTime? created;

  Datum({
    this.partnerid,
    this.partnername,
    this.description,
    this.status,
    this.email,
    this.country,
    this.profilepicture,
    this.tags,
    this.fburl,
    this.twitterurl,
    this.linkedinurl,
    this.partneradminid,
    this.created,
    this.countryname,
  });

  @override
  String toString() {
    return 'Datum(partnerid: $partnerid, partnername: $partnername, description: $description, status: $status, email: $email, country: $country, profilepicture: $profilepicture, tags: $tags, fburl: $fburl, twitterurl: $twitterurl, linkedinurl: $linkedinurl, partneradminid: $partneradminid, created: $created)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) {
    List<String>? tagsSlug = [];
    if (data['tags'] != null) {
      tagsSlug = jsonDecode(data['tags']).cast<String>().toList();
    }
    return Datum(
      partnerid: data['partnerid'] as String?,
      partnername: data['partnername'] as String?,
      description: data['description'] as String?,
      status: data['status'] as String?,
      email: data['email'] as String?,
      country: data['country'] as String?,
      countryname: data['countryname'] as String?,
      profilepicture: data['profilepicture'] as dynamic,
      tags: tagsSlug,
      fburl: data['fburl'] as dynamic,
      twitterurl: data['twitterurl'] as dynamic,
      linkedinurl: data['linkedinurl'] as dynamic,
      partneradminid: data['partneradminid'] as String?,
      created: data['created'] == null
          ? null
          : DateTime.parse(data['created'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        'partnerid': partnerid,
        'partnername': partnername,
        'description': description,
        'status': status,
        'email': email,
        'country': country,
        'profilepicture': profilepicture,
        'tags': tags,
        'fburl': fburl,
        'twitterurl': twitterurl,
        'linkedinurl': linkedinurl,
        'partneradminid': partneradminid,
        'created': created?.toIso8601String(),
        'countryname': countryname,
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
