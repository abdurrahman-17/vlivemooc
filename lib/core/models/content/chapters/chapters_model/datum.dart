import 'dart:convert';

import '../../content_model/poster.dart';
import 'contentdetail.dart';

class ChapterDatum {
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
  String? category;
  dynamic subcategory;
  String? seriesid;
  String? seriesname;
  String? seasonid;
  String? seasonname;
  int? seasonnum;
  int? episodenum;
  dynamic albumid;
  dynamic albumname;
  dynamic track;
  int? duration;
  dynamic bandorartist;
  dynamic skip;
  List<dynamic>? resources;
  List<Contentdetail>? contentdetails;
  bool isExpanded = false;
  int? watchedDuration;
  List<Poster>? poster;

  ChapterDatum({
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
    this.resources,
    this.poster,
    this.contentdetails,
    this.watchedDuration,
  });

  @override
  String toString() {
    return 'Datum(objectid: $objectid, objecttype: $objecttype, partnerid: $partnerid, title: $title, defaulttitle: $defaulttitle, defaultgenre: $defaultgenre, publishtime: $publishtime, endtime: $endtime, shortdescription: $shortdescription, ratingtype: $ratingtype, pgrating: $pgrating, parentid: $parentid, objectstatus: $objectstatus, genre: $genre, subgenre: $subgenre, thumbnail: $thumbnail, tags: $tags, contentlanguage: $contentlanguage, objectowner: $objectowner, jobid: $jobid, longdescription: $longdescription, objecttag: $objecttag, details: $details, productionyear: $productionyear, releasedate: $releasedate, imdbid: $imdbid, advisory: $advisory, metacontent: $metacontent, skilllevel: $skilllevel, estimatedtime: $estimatedtime, whatwelearn: $whatwelearn, category: $category, subcategory: $subcategory, seriesid: $seriesid, seriesname: $seriesname, seasonid: $seasonid, seasonname: $seasonname, seasonnum: $seasonnum, episodenum: $episodenum, albumid: $albumid, albumname: $albumname, track: $track, duration: $duration, bandorartist: $bandorartist, skip: $skip, resources: $resources, contentdetails: $contentdetails)';
  }

  factory ChapterDatum.fromMap(Map<String, dynamic> data) => ChapterDatum(
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
        category: data['category'] as String?,
        subcategory: data['subcategory'] as dynamic,
        seriesid: data['seriesid'] as String?,
        seriesname: data['seriesname'] as String?,
        seasonid: data['seasonid'] as String?,
        seasonname: data['seasonname'] as String?,
        seasonnum: data['seasonnum'] as int?,
        episodenum: data['episodenum'] as int?,
        albumid: data['albumid'] as dynamic,
        albumname: data['albumname'] as dynamic,
        track: data['track'] as dynamic,
        duration: data['duration'] as int?,
        watchedDuration: data['watchedDuration'] as int?,
        bandorartist: data['bandorartist'] as dynamic,
        skip: data['skip'] as dynamic,
        resources: data['resources'] as List<dynamic>?,
        contentdetails: (data['contentdetails'] as List<dynamic>?)
            ?.map((e) => Contentdetail.fromMap(e as Map<String, dynamic>))
            .toList(),
        poster: (data['poster'] as List<dynamic>?)
            ?.map((e) => Poster.fromMap(e as Map<String, dynamic>))
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
        'details': details,
        'productionyear': productionyear,
        'releasedate': releasedate,
        'imdbid': imdbid,
        'advisory': advisory,
        'metacontent': metacontent,
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
        'resources': resources,
        'poster': poster?.map((e) => e.toMap()).toList(),
        'watchedDuration': watchedDuration,
        'contentdetails': contentdetails?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChapterDatum].
  factory ChapterDatum.fromJson(String data) {
    return ChapterDatum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChapterDatum] to a JSON string.
  String toJson() => json.encode(toMap());
}
