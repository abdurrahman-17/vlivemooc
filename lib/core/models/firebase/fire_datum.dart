import 'dart:convert';

import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/content/content_model/poster.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../helpers/time_calculator.dart';

class FireDatum {
  String category;
  String? contentStatus;
  int? duration;
  String genre;
  String objectid;
  String? objecttype;
  List<Poster>? poster;
  String? status;
  String title;
  int? updatedAt;
  int? watchedDuration;
  String? likestatus;
  String? objectowner;
  Map<String, FireEpisode>? episodes;
  String? seriesid;
  int? seasonnum;
  int? episodenum;
  bool? inwatchlist;
  bool? isWatchedOnce;

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'contentStatus': contentStatus,
      'duration': duration,
      'genre': genre,
      'objectid': objectid,
      'objecttype': objecttype,
      'poster': poster?.map((e) => e.toMap()).toList(),
      'status': status,
      'title': title,
      'updatedAt': updatedAt,
      'watchedDuration': watchedDuration,
      'likestatus': likestatus,
      'objectowner': objectowner,
      'episodes': episodes?.map((key, value) => MapEntry(key, value.toMap())),
      'seriesid': seriesid,
      'seasonnum': seasonnum,
      'episodenum': episodenum,
      'inwatchlist': inwatchlist,
      'isWatchedOnce': isWatchedOnce,
    };
  }

  FireDatum({
    required this.category,
    this.contentStatus,
    required this.duration,
    required this.genre,
    required this.objectid,
    this.objecttype,
    required this.poster,
    required this.title,
    required this.likestatus,
    this.objectowner,
    this.status,
    this.updatedAt,
    this.watchedDuration,
    this.seriesid,
    this.seasonnum,
    this.episodenum,
    this.episodes,
    this.inwatchlist,
    this.isWatchedOnce,
  });

  factory FireDatum.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    Map<dynamic, dynamic>? episodesJson = snapshot['episodes'];
    Map<String, FireEpisode>? episodesMap;
    if (episodesJson != null) {
      episodesMap = episodesJson.map((key, value) {
        return MapEntry(key, FireEpisode.fromJson(value));
      });
    }


    return FireDatum(
      category: snapshot['category'],
      contentStatus: snapshot['contentStatus'],
      duration: snapshot['duration'],
      genre: snapshot['genre'],
      objectid: snapshot['objectid'],
      objecttype: snapshot['objecttype'],
      poster: snapshot['poster'] == null
          ? null
          : (snapshot['poster'] as List<dynamic>?)
          ?.map((e) => Poster.fromJson(jsonEncode(e)))
          .toList(),
      title: snapshot['title'],
      likestatus: snapshot['likestatus'],
      objectowner: snapshot['objectowner'],
      status: snapshot['status'],
      updatedAt: snapshot['updatedAt'] ?? 0,
      watchedDuration: snapshot['watchedDuration'] ?? 0,
      seriesid: snapshot['seriesid'],
      seasonnum: snapshot['seasonnum'],
      episodenum: snapshot['episodenum'],
      episodes: episodesMap,
      inwatchlist: snapshot['inwatchlist'],
      isWatchedOnce: snapshot['isWatchedOnce'],
    );
  }

  factory FireDatum.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? episodesJson = json['episodes'];
    Map<String, FireEpisode>? episodesMap;
    if (episodesJson != null) {
      episodesMap = episodesJson.map((key, value) {
        return MapEntry(key, FireEpisode.fromJson(value));
      });
    }
    return FireDatum(
      category: json['category'],
      contentStatus: json['contentStatus'],
      duration: json['duration'],
      genre: json['genre'],
      objectid: json['objectid'],
      objecttype: json['objecttype'],
      poster: json['poster'] == null
          ? null
          : (json['poster'] as List<dynamic>?)
          ?.map((e) => Poster.fromMap(e as Map<String, dynamic>))
          .toList(),
      title: json['title'],
      likestatus: json['likestatus'],
      objectowner: json['objectowner'],
      status: json['status'],
      updatedAt: json['updatedAt'] ?? 0,
      watchedDuration: json['watchedDuration'] ?? 0,
      seriesid: json['seriesid'],
      seasonnum: json['seasonnum'],
      episodenum: json['episodenum'],
      episodes: episodesMap,
      inwatchlist: json['inwatchlist'],
      isWatchedOnce: json['isWatchedOnce'],
    );
  }

  void updateBasicInfo(Datum content) {
    objectid = content.objectid;
    objecttype = content.objecttype!;
    category = content.category!;
    title = content.title!;
    genre = content.selectedGenre??content.genre!;
    poster = content.poster;
    contentStatus = StringConstants.active;
    duration = content.duration;
    objectowner = content.objectowner;
    updatedAt = TimeCalculator().currentTime();

  }

  List<FireEpisode> getEpisodesList() {
    List<FireEpisode> fireEpisodes = [];
    if (episodes != null) {
      episodes?.forEach((key, value) {
        fireEpisodes.add(value);
      });
    }
    return fireEpisodes;
  }
}



class FireEpisode {
  String category;
  String contentStatus;
  int duration;
  int episodenum;
  String genre;
  String? nextEpisodeId;
  String objectid;
  String objecttype;
  List<Poster>? poster;
  int seasonnum;
  String seriesid;
  String status;
  String title;
  int updatedAt;
  int watchedDuration;
  String? likestatus;
  String? objectowner;
  bool? isWatchedOnce;

FireEpisode({
    required this.category,
    required this.contentStatus,
    required this.duration,
    required this.episodenum,
    required this.genre,
    required this.nextEpisodeId,
    required this.objectid,
    required this.objecttype,
    required this.poster,
    required this.seasonnum,
    required this.seriesid,
    required this.status,
    required this.title,
    required this.updatedAt,
    required this.watchedDuration,
    required this.likestatus,
    required this.objectowner,
    required this.isWatchedOnce,
  });

  factory FireEpisode.fromJson(Map<dynamic, dynamic> json) {
    return FireEpisode(
      category: json['category'],
      contentStatus: json['contentStatus'],
      duration: json['duration'],
      episodenum: json['episodenum'],
      genre: json['genre'],
      nextEpisodeId: json['nextepisodeid'],
      objectid: json['objectid'],
      objecttype: json['objecttype'],
      poster: json['poster'] == null
          ? null
          : (json['poster'] as List<dynamic>?)
          ?.map((e) => Poster.fromMap(e as Map<dynamic, dynamic>))
          .toList(),
      seasonnum: json['seasonnum'],
      seriesid: json['seriesid'],
      status: json['status'],
      title: json['title'],
      updatedAt: json['updatedAt'],
      watchedDuration: json['watchedDuration'],
      objectowner: json['objectowner'],
      likestatus: json['likestatus'],
      isWatchedOnce: json['isWatchedOnce'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'contentStatus': contentStatus,
      'duration': duration,
      'episodenum': episodenum,
      'genre': genre,
      'nextEpisodeId': nextEpisodeId,
      'objectid': objectid,
      'objecttype': objecttype,
      'poster': poster?.map((e) => e.toMap()).toList(),
      'seasonnum': seasonnum,
      'seriesid': seriesid,
      'status': status,
      'title': title,
      'updatedAt': updatedAt,
      'watchedDuration': watchedDuration,
      'likestatus': likestatus,
      'objectowner': objectowner,
      'isWatchedOnce': isWatchedOnce,
    };
  }
}
