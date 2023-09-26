import 'dart:convert';

class SubscriberModel {
  String subscriberId;
  String subscriberName;
  String? address1;
  String? address2;
  String? city;
  String? region;
  String? zipcode;
  bool country;
  String subscriberCountry;
  String? mobileNo;
  String? email;
  String? setPassword;
  String profileId;
  String profileName;
  String kidsMode;
  String? gender;
  String? dob;
  String? pgratting;
  String profilePin;
  String? picture;
  int? age;
  DateTime created;
  int loginExpiry;

  SubscriberModel({
    required this.subscriberId,
    required this.subscriberName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.region,
    required this.zipcode,
    required this.country,
    required this.subscriberCountry,
    required this.mobileNo,
    required this.email,
    required this.setPassword,
    required this.profileId,
    required this.profileName,
    required this.kidsMode,
    required this.gender,
    required this.dob,
    required this.pgratting,
    required this.profilePin,
    required this.picture,
    required this.age,
    required this.created,
    required this.loginExpiry,
  });

  factory SubscriberModel.fromMap(Map<String, dynamic> map) {
    return SubscriberModel(
      subscriberId: map['subscriberid'],
      subscriberName: map['subscribername'],
      address1: map['address1'],
      address2: map['address2'],
      city: map['city'],
      region: map['region'],
      zipcode: map['zipcode'],
      country: map['country'],
      subscriberCountry: map['subscribercountry'],
      mobileNo: map['mobileno'],
      email: map['email'],
      setPassword: map['setpassword'],
      profileId: map['profileid'],
      profileName: map['profilename'],
      kidsMode: map['kidsmode'],
      gender: map['gender'],
      dob: map['dob'],
      pgratting: map['pgratting'],
      profilePin: map['profilepin'],
      picture: map['picture'],
      age: map['age'],
      created: DateTime.parse(map['created']),
      loginExpiry: map['loginexpiry'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subscriberid': subscriberId,
      'subscribername': subscriberName,
      'address1': address1,
      'address2': address2,
      'city': city,
      'region': region,
      'zipcode': zipcode,
      'country': country,
      'subscribercountry': subscriberCountry,
      'mobileno': mobileNo,
      'email': email,
      'setpassword': setPassword,
      'profileid': profileId,
      'profilename': profileName,
      'kidsmode': kidsMode,
      'gender': gender,
      'dob': dob,
      'pgratting': pgratting,
      'profilepin': profilePin,
      'picture': picture,
      'age': age,
      'created': created.toIso8601String(),
      'loginexpiry': loginExpiry,
    };
  }

  factory SubscriberModel.fromJson(String json) {
    return SubscriberModel.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
