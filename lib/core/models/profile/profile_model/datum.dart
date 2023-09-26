import 'dart:convert';

class Datum {
  String? profileid;
  String? profilename;
  dynamic pgratting;
  dynamic picture;
  String? kidsmode;
  dynamic gender;
  dynamic dob;
  dynamic age;
  String? profilepin;
  String? created;

  Datum({
    this.profileid,
    this.profilename,
    this.pgratting,
    this.picture,
    this.kidsmode,
    this.gender,
    this.dob,
    this.age,
    this.profilepin,
    this.created,
  });

  @override
  String toString() {
    return 'Datum(profileid: $profileid, profilename: $profilename, pgratting: $pgratting, picture: $picture, kidsmode: $kidsmode, gender: $gender, dob: $dob, age: $age, profilepin: $profilepin, created: $created)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        profileid: data['profileid'] as String?,
        profilename: data['profilename'] as String?,
        pgratting: data['pgratting'] as dynamic,
        picture: data['picture'] as dynamic,
        kidsmode: data['kidsmode'] as String?,
        gender: data['gender'] as dynamic,
        dob: data['dob'] as dynamic,
        age: data['age'] as dynamic,
        profilepin: data['profilepin'] as String?,
        created: data['created'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'profileid': profileid,
        'profilename': profilename,
        'pgratting': pgratting,
        'picture': picture,
        'kidsmode': kidsmode,
        'gender': gender,
        'dob': dob,
        'age': age,
        'profilepin': profilepin,
        'created': created,
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
