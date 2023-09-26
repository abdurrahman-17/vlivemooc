import 'dart:convert';

class Datum {
  String? planid;
  String? planname;
  String? plantype;
  String? category;
  dynamic description;
  String? planinterval;
  String? planstatus;
  int? trialperioddays;
  String? region;
  List<dynamic>? country;
  List<dynamic>? paymentoptions;
  int? graceperiod;
  int? billbeforedays;
  dynamic exclusionlist;
  dynamic plantag;
  String? quality;
  int? devicelimit;
  int? concurrencylimit;
  List<dynamic>? availabilityset;
  int? weight;
  String? initiatedby;
  String? updatedby;
  String? updatedon;
  String? created;
  String? picture;
  int? amount;
  String? currency;

  Datum({
    this.planid,
    this.planname,
    this.plantype,
    this.category,
    this.description,
    this.planinterval,
    this.planstatus,
    this.trialperioddays,
    this.region,
    this.country,
    this.paymentoptions,
    this.graceperiod,
    this.billbeforedays,
    this.exclusionlist,
    this.plantag,
    this.quality,
    this.devicelimit,
    this.concurrencylimit,
    this.availabilityset,
    this.weight,
    this.initiatedby,
    this.updatedby,
    this.updatedon,
    this.created,
    this.picture,
    this.amount,
    this.currency,
  });

  @override
  String toString() {
    return 'Datum(planid: $planid, planname: $planname, plantype: $plantype, category: $category, description: $description, planinterval: $planinterval, planstatus: $planstatus, trialperioddays: $trialperioddays, region: $region, country: $country, paymentoptions: $paymentoptions, graceperiod: $graceperiod, billbeforedays: $billbeforedays, exclusionlist: $exclusionlist, plantag: $plantag, quality: $quality, devicelimit: $devicelimit, concurrencylimit: $concurrencylimit, availabilityset: $availabilityset, weight: $weight, initiatedby: $initiatedby, updatedby: $updatedby, updatedon: $updatedon, created: $created, picture: $picture, amount: $amount, currency: $currency)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        planid: data['planid'] as String?,
        planname: data['planname'] as String?,
        plantype: data['plantype'] as String?,
        category: data['category'] as String?,
        description: data['description'] as dynamic,
        planinterval: data['planinterval'] as String?,
        planstatus: data['planstatus'] as String?,
        trialperioddays: data['trialperioddays'] as int?,
        region: data['region'] as String?,
        country: data['country'] as List<dynamic>?,
        paymentoptions: data['paymentoptions'] as List<dynamic>?,
        graceperiod: data['graceperiod'] as int?,
        billbeforedays: data['billbeforedays'] as int?,
        exclusionlist: data['exclusionlist'] as dynamic,
        plantag: data['plantag'] as dynamic,
        quality: data['quality'] as String?,
        devicelimit: data['devicelimit'] as int?,
        concurrencylimit: data['concurrencylimit'] as int?,
        availabilityset: data['availabilityset'] as List<dynamic>?,
        weight: data['weight'] as int?,
        initiatedby: data['initiatedby'] as String?,
        updatedby: data['updatedby'] as String?,
        updatedon: data['updatedon'] as String?,
        created: data['created'] as String?,
        picture: data['picture'] as String?,
        amount: data['amount'] as int?,
        currency: data['currency'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'planid': planid,
        'planname': planname,
        'plantype': plantype,
        'category': category,
        'description': description,
        'planinterval': planinterval,
        'planstatus': planstatus,
        'trialperioddays': trialperioddays,
        'region': region,
        'country': country,
        'paymentoptions': paymentoptions,
        'graceperiod': graceperiod,
        'billbeforedays': billbeforedays,
        'exclusionlist': exclusionlist,
        'plantag': plantag,
        'quality': quality,
        'devicelimit': devicelimit,
        'concurrencylimit': concurrencylimit,
        'availabilityset': availabilityset,
        'weight': weight,
        'initiatedby': initiatedby,
        'updatedby': updatedby,
        'updatedon': updatedon,
        'created': created,
        'picture': picture,
        'amount': amount,
        'currency': currency,
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
