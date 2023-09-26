import 'dart:convert';

import '../../chapters/chapters_model/chapters_model.dart';

class ModuleDatum {
  String? objectid;
  String? objecttype;
  String? partnerid;
  String? title;
  String? defaulttitle;
  String? defaultgenre;
  String? publishtime;
  String? endtime;
  String? shortdescription;
  String? ratingtype;
  String? pgrating;
  dynamic parentid;
  String? objectstatus;
  String? genre;
  dynamic subgenre;
  dynamic thumbnail;
  dynamic tags;
  List<dynamic>? contentlanguage;
  dynamic objectowner;
  dynamic jobid;
  dynamic longdescription;
  dynamic objecttag;
  dynamic details;
  dynamic productionyear;
  dynamic releasedate;
  dynamic imdbid;
  dynamic advisory;
  dynamic metacontent;
  dynamic skilllevel;
  int? estimatedtime;
  dynamic whatwelearn;
  String? seriesid;
  String? seriesname;
  int? seasonnum;
  int? duration;
  int? chaptersDuration;
  int? episodecount;
  List<dynamic>? resources;
  //custom data
  bool isExpaned = false;
  ChaptersModel? chapter;

  ModuleDatum({
    this.objectid,
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
    this.metacontent,
    this.skilllevel,
    this.estimatedtime,
    this.whatwelearn,
    this.seriesid,
    this.seriesname,
    this.seasonnum,
    this.duration,
    this.episodecount,
    this.resources,
  });

  @override
  String toString() {
    return 'Datum(objectid: $objectid, objecttype: $objecttype, partnerid: $partnerid, title: $title, defaulttitle: $defaulttitle, defaultgenre: $defaultgenre, publishtime: $publishtime, endtime: $endtime, shortdescription: $shortdescription, ratingtype: $ratingtype, pgrating: $pgrating, parentid: $parentid, objectstatus: $objectstatus, genre: $genre, subgenre: $subgenre, thumbnail: $thumbnail, tags: $tags, contentlanguage: $contentlanguage, objectowner: $objectowner, jobid: $jobid, longdescription: $longdescription, objecttag: $objecttag, details: $details, productionyear: $productionyear, releasedate: $releasedate, imdbid: $imdbid, advisory: $advisory, metacontent: $metacontent, skilllevel: $skilllevel, estimatedtime: $estimatedtime, whatwelearn: $whatwelearn, seriesid: $seriesid, seriesname: $seriesname, seasonnum: $seasonnum, duration: $duration, episodecount: $episodecount, resources: $resources)';
  }

  factory ModuleDatum.fromMap(Map<String, dynamic> data) => ModuleDatum(
        objectid: data['objectid'] as String?,
        objecttype: data['objecttype'] as String?,
        partnerid: data['partnerid'] as String?,
        title: data['title'] as String?,
        defaulttitle: data['defaulttitle'] as String?,
        defaultgenre: data['defaultgenre'] as String?,
        publishtime: data['publishtime'] as String?,
        endtime: data['endtime'] as String?,
        shortdescription: data['shortdescription'] as String?,
        ratingtype: data['ratingtype'] as String?,
        pgrating: data['pgrating'] as String?,
        parentid: data['parentid'] as dynamic,
        objectstatus: data['objectstatus'] as String?,
        genre: data['genre'] as String?,
        subgenre: data['subgenre'] as dynamic,
        thumbnail: data['thumbnail'] as dynamic,
        tags: data['tags'] as dynamic,
        contentlanguage: data['contentlanguage'] as List<dynamic>?,
        objectowner: data['objectowner'] as dynamic,
        jobid: data['jobid'] as dynamic,
        longdescription: data['longdescription'] as dynamic,
        objecttag: data['objecttag'] as dynamic,
        details: data['details'] as dynamic,
        productionyear: data['productionyear'] as dynamic,
        releasedate: data['releasedate'] as dynamic,
        imdbid: data['imdbid'] as dynamic,
        advisory: data['advisory'] as dynamic,
        metacontent: data['metacontent'] as dynamic,
        skilllevel: data['skilllevel'] as dynamic,
        estimatedtime: data['estimatedtime'] as int?,
        whatwelearn: data['whatwelearn'] as dynamic,
        seriesid: data['seriesid'] as String?,
        seriesname: data['seriesname'] as String?,
        seasonnum: data['seasonnum'] as int?,
        duration: data['duration'] as int?,
        episodecount: data['episodecount'] as int?,
        resources: data['resources'] as List<dynamic>?,
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
        'details': details,
        'productionyear': productionyear,
        'releasedate': releasedate,
        'imdbid': imdbid,
        'advisory': advisory,
        'metacontent': metacontent,
        'skilllevel': skilllevel,
        'estimatedtime': estimatedtime,
        'whatwelearn': whatwelearn,
        'seriesid': seriesid,
        'seriesname': seriesname,
        'seasonnum': seasonnum,
        'duration': duration,
        'episodecount': episodecount,
        'resources': resources,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ModuleDatum].
  factory ModuleDatum.fromJson(String data) {
    return ModuleDatum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ModuleDatum] to a JSON string.
  String toJson() => json.encode(toMap());
}
