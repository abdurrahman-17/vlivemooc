import 'dart:convert';

class Response {
  String? idevent;
  String? instructorid;
  String? title;
  String? description;
  String? type;
  String? amount;
  String? eventtype;
  int? totalseats;
  String? purchasetype;
  String? status;
  String? calendlyeventtype;
  String? initiatedBy;
  String? thumbnail;
  String? updatedby;
  String? updatedon;
  String? created;
  String? eventid;
  String? webinarUrl;
  String? hostUrl;
  String? calendlyid;
  String? scheduleid;
  String? name;
  DateTime? starttime;

  Response({
    this.idevent,
    this.instructorid,
    this.title,
    this.description,
    this.type,
    this.amount,
    this.eventtype,
    this.totalseats,
    this.purchasetype,
    this.status,
    this.calendlyeventtype,
    this.initiatedBy,
    this.thumbnail,
    this.updatedby,
    this.updatedon,
    this.created,
    this.eventid,
    this.webinarUrl,
    this.hostUrl,
    this.calendlyid,
    this.scheduleid,
    this.starttime,
    this.name,
  });

  @override
  String toString() {
    return 'Response(idevent: $idevent, instructorid: $instructorid, title: $title, description: $description, type: $type, amount: $amount, eventtype: $eventtype, totalseats: $totalseats, purchasetype: $purchasetype, status: $status, calendlyeventtype: $calendlyeventtype, initiatedBy: $initiatedBy, thumbnail: $thumbnail, updatedby: $updatedby, updatedon: $updatedon, created: $created, eventid: $eventid, webinarUrl: $webinarUrl, hostUrl: $hostUrl, calendlyid: $calendlyid, scheduleid: $scheduleid, starttime: $starttime)';
  }

  factory Response.fromMap(Map<String, dynamic> data) => Response(
      idevent: data['idevent'] as String?,
      instructorid: data['instructorid'] as String?,
      title: data['title'] as String?,
      description: data['description'] as String?,
      type: data['type'] as String?,
      amount: data['amount'] as String?,
      eventtype: data['eventtype'] as String?,
     //category
      totalseats: data['totalseats'] as int?,
      purchasetype: data['purchasetype'] as String?,
      status: data['status'] as String?,
      calendlyeventtype: data['calendlyeventtype'] as String?,
      initiatedBy: data['initiatedBy'] as String?,
      thumbnail: data['thumbnail'] as String?,
      updatedby: data['updatedby'] as String?,
      updatedon: data['updatedon'] as String?,
      created: data['created'] as String?,
      eventid: data['eventid'] as String?,
      webinarUrl: data['webinarURL'] as String?,
      hostUrl: data['hostURL'] as String?,
      calendlyid: data['calendlyid'] as String?,
      scheduleid: data['Scheduleid'] as String?,
      starttime: data['starttime'] == null
          ? null
          : DateTime.parse(data['starttime'] as String),
      name: data['name'] as String?);

  Map<String, dynamic> toMap() => {
        'idevent': idevent,
        'instructorid': instructorid,
        'title': title,
        'description': description,
        'type': type,
        'amount': amount,
        'eventtype': eventtype,
        'totalseats': totalseats,
        'purchasetype': purchasetype,
        'status': status,
        'calendlyeventtype': calendlyeventtype,
        'initiatedBy': initiatedBy,
        'thumbnail': thumbnail,
        'updatedby': updatedby,
        'updatedon': updatedon,
        'created': created,
        'eventid': eventid,
        'webinarURL': webinarUrl,
        'hostURL': hostUrl,
        'calendlyid': calendlyid,
        'Scheduleid': scheduleid,
        'starttime': starttime?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Response].
  factory Response.fromJson(String data) {
    return Response.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Response] to a JSON string.
  String toJson() => json.encode(toMap());
}
