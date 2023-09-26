import 'dart:convert';

class Datum {
  dynamic purchaseid;
  String? subscriberid;
  String? objectid;
  String? objecttype;
  dynamic objecttitle;
  String? purchasetype;
  int? amount;
  String? currency;
  String? invoiceid;
  int? paymentid;
  String? expiry;
  String? purchasestatus;
  dynamic couponid;
  String? availabilityid;
  String? initiatedby;
  String? updatedby;
  String? updatedon;
  String? created;

  Datum({
    this.purchaseid,
    this.subscriberid,
    this.objectid,
    this.objecttype,
    this.objecttitle,
    this.purchasetype,
    this.amount,
    this.currency,
    this.invoiceid,
    this.paymentid,
    this.expiry,
    this.purchasestatus,
    this.couponid,
    this.availabilityid,
    this.initiatedby,
    this.updatedby,
    this.updatedon,
    this.created,
  });

  @override
  String toString() {
    return 'Datum(purchaseid: $purchaseid, subscriberid: $subscriberid, objectid: $objectid, objecttype: $objecttype, objecttitle: $objecttitle, purchasetype: $purchasetype, amount: $amount, currency: $currency, invoiceid: $invoiceid, paymentid: $paymentid, expiry: $expiry, purchasestatus: $purchasestatus, couponid: $couponid, availabilityid: $availabilityid, initiatedby: $initiatedby, updatedby: $updatedby, updatedon: $updatedon, created: $created)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        purchaseid: data['purchaseid'] as dynamic,
        subscriberid: data['subscriberid'] as String?,
        objectid: data['objectid'] as String?,
        objecttype: data['objecttype'] as String?,
        objecttitle: data['objecttitle'] as dynamic,
        purchasetype: data['purchasetype'] as String?,
        amount: data['amount'] as int?,
        currency: data['currency'] as String?,
        invoiceid: data['invoiceid'] as String?,
        paymentid: data['paymentid'] as int?,
        expiry: data['expiry'] as String?,
        purchasestatus: data['purchasestatus'] as String?,
        couponid: data['couponid'] as dynamic,
        availabilityid: data['availabilityid'] as String?,
        initiatedby: data['initiatedby'] as String?,
        updatedby: data['updatedby'] as String?,
        updatedon: data['updatedon'] as String?,
        created: data['created'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'purchaseid': purchaseid,
        'subscriberid': subscriberid,
        'objectid': objectid,
        'objecttype': objecttype,
        'objecttitle': objecttitle,
        'purchasetype': purchasetype,
        'amount': amount,
        'currency': currency,
        'invoiceid': invoiceid,
        'paymentid': paymentid,
        'expiry': expiry,
        'purchasestatus': purchasestatus,
        'couponid': couponid,
        'availabilityid': availabilityid,
        'initiatedby': initiatedby,
        'updatedby': updatedby,
        'updatedon': updatedon,
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
