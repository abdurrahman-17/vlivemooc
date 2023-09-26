import 'dart:convert';

class SessionDatum {
  String? idsession;
  String? eventid;
  String? description;
  String? subscriberid;
  String? hostid;
  String? calendlyid;
  String? scheduleid;
  String? purchaseid;
  DateTime? starttime;
  String? endtime;
  String? eventtype;
  String? type;
  String? status;
  String? stepexecutionArn;
  String? initiatedby;
  String? updatedby;
  String? updatedon;
  String? created;
  dynamic joinUrl;
  String? title;
  dynamic hostUrl;

  SessionDatum({
    this.idsession,
    this.eventid,
    this.description,
    this.subscriberid,
    this.hostid,
    this.calendlyid,
    this.scheduleid,
    this.purchaseid,
    this.starttime,
    this.endtime,
    this.eventtype,
    this.status,
    this.stepexecutionArn,
    this.initiatedby,
    this.updatedby,
    this.updatedon,
    this.created,
    this.joinUrl,
    this.hostUrl,
    this.type,
    this.title,
  });

  @override
  String toString() {
    return 'SessionDatum(idsession: $idsession, eventid: $eventid, subscriberid: $subscriberid,description: $description, hostid: $hostid, calendlyid: $calendlyid, scheduleid: $scheduleid, purchaseid: $purchaseid, starttime: $starttime, endtime: $endtime, eventtype: $eventtype, status: $status, stepexecutionArn: $stepexecutionArn, initiatedby: $initiatedby, updatedby: $updatedby, updatedon: $updatedon, created: $created, joinUrl: $joinUrl, hostUrl: $hostUrl)';
  }

  factory SessionDatum.fromMap(Map<String, dynamic> data) => SessionDatum(
        idsession: data['idsession'] as String?,
        eventid: data['eventid'] as String?,
    description: data['description'] as String?,
        subscriberid: data['subscriberid'] as String?,
        hostid: data['hostid'] as String?,
        calendlyid: data['calendlyid'] as String?,
        scheduleid: data['Scheduleid'] as String?,
        purchaseid: data['purchaseid'] as String?,
        starttime: data['starttime'] == null
            ? null
            : DateTime.parse(data['starttime'] as String),
        endtime: data['endtime'] as String?,
        eventtype: data['eventtype'] as String?,
        status: data['status'] as String?,
        stepexecutionArn: data['stepexecutionARN'] as String?,
        initiatedby: data['initiatedby'] as String?,
        updatedby: data['updatedby'] as String?,
        updatedon: data['updatedon'] as String?,
        created: data['created'] as String?,
        joinUrl: data['joinURL'] as dynamic,
        hostUrl: data['hostURL'] as dynamic,
        type: data['type'] as String?,
        title: data['title'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'idsession': idsession,
        'eventid': eventid,
        'description': description,
        'subscriberid': subscriberid,
        'hostid': hostid,
        'calendlyid': calendlyid,
        'Scheduleid': scheduleid,
        'purchaseid': purchaseid,
        'starttime': starttime?.toIso8601String(),
        'endtime': endtime,
        'eventtype': eventtype,
        'status': status,
        'stepexecutionARN': stepexecutionArn,
        'initiatedby': initiatedby,
        'updatedby': updatedby,
        'updatedon': updatedon,
        'created': created,
        'joinURL': joinUrl,
        'hostURL': hostUrl,
        'type': type,
        'title': title,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SessionDatum].
  factory SessionDatum.fromJson(String data) {
    return SessionDatum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SessionDatum] to a JSON string.
  String toJson() => json.encode(toMap());
}
