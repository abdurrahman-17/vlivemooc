import 'dart:convert';

import 'package:vlivemooc/core/models/firebase/fire_datum.dart';

import 'contentdetail.dart';
import 'details.dart';
// import 'metacontent.dart';
import 'poster.dart';
class Datum {
  String objectid;
  String? objecttype;
  String? partnerid;
  String? title;
  String? defaulttitle;
  String? defaultgenre;
  String? publishtime;
  String? endtime;
  dynamic shortdescription;
  String? ratingtype;
  String? pgrating;
  dynamic parentid;
  String? objectstatus;
  String? genre;
  dynamic subgenre;
  dynamic thumbnail;
  List<dynamic>? tags;
  List<dynamic>? contentlanguage;
  String? objectowner;
  dynamic jobid;
  String? longdescription;
  dynamic objecttag;
  Details? details;
  dynamic productionyear;
  dynamic releasedate;
  dynamic imdbid;
  dynamic advisory;
  // Metacontent? metacontent;
  dynamic skilllevel;
  dynamic estimatedtime;
  dynamic whatwelearn;
  String? category;
  dynamic subcategory;
  dynamic seriesid;
  dynamic seriesname;
  dynamic seasonid;
  dynamic seasonname;
  dynamic seasonnum;
  int? seasoncount;

  int? episodenum;
  dynamic albumid;
  dynamic albumname;
  dynamic track;
  int? duration;
  int? totalduration;
  dynamic bandorartist;
  dynamic skip;
  String? playlead;
  List<Poster>? poster;
  List<dynamic>? resources;
  List<Contentdetail>? contentdetails;
  final dynamic trailer;
  int? watchedDuration;
  bool inwatchlist=false;

  FireDatum? fireDatum;

  String? selectedGenre;

  Datum(
      {required this.objectid,
        this.objecttype,
        this.partnerid,
        this.title,
        this.defaulttitle,
        this.defaultgenre,
        this.publishtime,
        this.endtime,
        this.shortdescription,
        this.ratingtype,
        this.pgrating,
        this.parentid,
        this.objectstatus,
        this.genre,
        this.subgenre,
        this.thumbnail,
        this.tags,
        this.contentlanguage,
        this.objectowner,
        this.jobid,
        this.longdescription,
        this.objecttag,
        this.details,
        this.productionyear,
        this.releasedate,
        this.imdbid,
        this.advisory,
        // this.metacontent,
        this.skilllevel,
        this.estimatedtime,
        this.whatwelearn,
        this.category,
        this.subcategory,
        this.seriesid,
        this.seriesname,
        this.seasonid,
        this.seasonname,
        this.seasonnum,
        this.episodenum,
        this.albumid,
        this.albumname,
        this.track,
        this.duration,
        this.bandorartist,
        this.skip,
        this.poster,
        this.resources,
        this.contentdetails,
        this.trailer,
        this.watchedDuration,
        this.seasoncount,
        this.playlead,
        this.totalduration
      });

  @override
  String toString() {
    return 'Datum(objectid: $objectid, objecttype: $objecttype,playlead: $playlead, partnerid: $partnerid,seasoncount: $seasoncount, title: $title, defaulttitle: $defaulttitle, defaultgenre: $defaultgenre, publishtime: $publishtime, endtime: $endtime, shortdescription: $shortdescription, ratingtype: $ratingtype, pgrating: $pgrating, parentid: $parentid, objectstatus: $objectstatus, genre: $genre, subgenre: $subgenre, thumbnail: $thumbnail, tags: $tags, contentlanguage: $contentlanguage, objectowner: $objectowner, jobid: $jobid, longdescription: $longdescription, objecttag: $objecttag, details: $details, productionyear: $productionyear, releasedate: $releasedate, imdbid: $imdbid, advisory: $advisory, skilllevel: $skilllevel, estimatedtime: $estimatedtime, whatwelearn: $whatwelearn, category: $category, subcategory: $subcategory, seriesid: $seriesid, seriesname: $seriesname, seasonid: $seasonid, seasonname: $seasonname, seasonnum: $seasonnum, episodenum: $episodenum, albumid: $albumid, albumname: $albumname, track: $track, duration: $duration, bandorartist: $bandorartist, skip: $skip, poster: $poster, resources: $resources, contentdetails: $contentdetails, totalduration: $totalduration)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
    objectid: data['objectid'] as String,
    trailer: data['trailer']!=null
        ?  (data['trailer']==[]?"":  data['trailer'][0]['filelist'][0]['filename'])
        : "",
    objecttype: data['objecttype'] as String?,
    partnerid: data['partnerid'] as String?,
    title: data['title'] as String?,
    defaulttitle: data['defaulttitle'] as String?,
    defaultgenre: data['defaultgenre'] as String?,
    publishtime: data['publishtime'] as String?,
    endtime: data['endtime'] as String?,
    shortdescription: data['shortdescription'] as dynamic,
    ratingtype: data['ratingtype'] as String?,
    pgrating: data['pgrating'] as String?,
    parentid: data['parentid'] as dynamic,
    objectstatus: data['objectstatus'] as String?,
    genre: data['genre'] as String?,
    subgenre: data['subgenre'] as dynamic,
    thumbnail: data['thumbnail'] as dynamic,
    tags: data['tags'] as List<dynamic>?,
    contentlanguage: data['contentlanguage'] as List<dynamic>?,
    objectowner: data['objectowner'] as String?,
    jobid: data['jobid'] as dynamic,
    longdescription: data['longdescription'] as String?,
    objecttag: data['objecttag'] as dynamic,
    seasoncount: data['seasoncount'] as int?,
    details: data['details'] == null
        ? null
        : Details.fromMap(data['details'] as Map<String, dynamic>),
    productionyear: data['productionyear'] as dynamic,
    releasedate: data['releasedate'] as dynamic,
    imdbid: data['imdbid'] as dynamic,
    advisory: data['advisory'] as dynamic,
    // metacontent: data['metacontent'] == null
    //     ? null
    //     : Metacontent.fromMap(data['metacontent'] as Map<String, dynamic>),
    skilllevel: data['skilllevel'] as dynamic,
    estimatedtime: data['estimatedtime'] as dynamic,
    whatwelearn: data['whatwelearn'] as dynamic,
    category: data['category'] as String?,
    subcategory: data['subcategory'] as dynamic,
    seriesid: data['seriesid'] as dynamic,
    seriesname: data['seriesname'] as dynamic,
    seasonid: data['seasonid'] as dynamic,
    seasonname: data['seasonname'] as dynamic,
    seasonnum: data['seasonnum'] as dynamic,
    episodenum: data['episodenum'] as dynamic,
    albumid: data['albumid'] as dynamic,
    albumname: data['albumname'] as dynamic,
    track: data['track'] as dynamic,
    duration: data['duration'] as int?,
    totalduration: data['totalduration'] as int?,
    watchedDuration: data['watchedDuration'] as int?,
    playlead: data['playlead'] as String?,
    bandorartist: data['bandorartist'] as dynamic,
    skip: data['skip'] as dynamic,
    poster: (data['poster'] as List<dynamic>?)
        ?.map((e) => Poster.fromMap(e as Map<String, dynamic>))
        .toList(),
    resources: data['resources'] as List<dynamic>?,
    contentdetails: (data['contentdetails'] as List<dynamic>?)
        ?.map((e) => Contentdetail.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'objectid': objectid,
    'objecttype': objecttype,
    'partnerid': partnerid,
    'title': title,
    'defaulttitle': defaulttitle,
    'defaultgenre': defaultgenre,
    'publishtime': publishtime,
    'endtime': endtime,
    'shortdescription': shortdescription,
    'ratingtype': ratingtype,
    'pgrating': pgrating,
    'parentid': parentid,
    'objectstatus': objectstatus,
    'genre': genre,
    'subgenre': subgenre,
    'thumbnail': thumbnail,
    'tags': tags,
    'contentlanguage': contentlanguage,
    'objectowner': objectowner,
    'jobid': jobid,
    'longdescription': longdescription,
    'objecttag': objecttag,
    'details': details?.toMap(),
    'productionyear': productionyear,
    'releasedate': releasedate,
    'seasoncount': seasoncount,
    'imdbid': imdbid,
    'advisory': advisory,
    // 'metacontent': metacontent?.toMap(),
    'skilllevel': skilllevel,
    'estimatedtime': estimatedtime,
    'whatwelearn': whatwelearn,
    'category': category,
    'subcategory': subcategory,
    'seriesid': seriesid,
    'seriesname': seriesname,
    'seasonid': seasonid,
    'seasonname': seasonname,
    'seasonnum': seasonnum,
    'episodenum': episodenum,
    'albumid': albumid,
    'albumname': albumname,
    'track': track,
    'duration': duration,
    'bandorartist': bandorartist,
    'skip': skip,
    'poster': poster?.map((e) => e.toMap()).toList(),
    'resources': resources,
    'contentdetails': contentdetails?.map((e) => e.toMap()).toList(),
    'watchedDuration': watchedDuration,
    'playlead': playlead,
    'totalduration': totalduration,

  };

  /// `dart:convert`ain
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
