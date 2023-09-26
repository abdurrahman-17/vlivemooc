import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/network/network_handler.dart';

import '../helpers/debouncer.dart';
import '../models/coaches/coach_model/datum.dart' as coach;
import '../models/coaches/events_model/response.dart';
import '../models/content/content_model/datum.dart';

class SearchProvider with ChangeNotifier {
  String query = "";
  List<Datum> allResults = [];
  List<Datum> videoResults = [];
  List<Datum> courseResults = [];
  List<coach.Datum> coachResults = [];
  List<Response> eventResults = [];

  bool isSearching = false;
  final _debouncer = Debouncer(milliseconds: 500);
  setSearch(String search) {
    if (search == query) {
      return;
    }
    query = search;
    _debouncer.run(() {
      /*if (query.isNotEmpty) {*/
      startSearching();
      /* }*/
    });
    notifyListeners();
  }

  startSearching() async {
    isSearching = true;
    notifyListeners();
    List<Datum> datum = [];

    // try {
    var results = await NetworkHandler.performSearch(query);
    List<coach.Datum> slugCoachResults = [];
    List<Response> slugEventsResults = [];
    for (var i = 0; i < results.length; i++) {
      var resultObject = results[i];
      if (resultObject['objecttype'] == "INSTRUCTOR") {
        coach.Datum instructor = coach.Datum.fromMap(resultObject);
        if (instructor.status == "ACTIVE") {
          slugCoachResults.add(instructor);
        }
      } else if (resultObject['objecttype'] == ContentModel.content ||
          resultObject['objecttype'] == ContentModel.course ||
          resultObject['objecttype'] == ContentModel.series) {
        datum.add(Datum.fromMap(resultObject));
      } else if (resultObject['objecttype'] == "EVENT") {
        Response event = Response.fromMap(resultObject);
        if (event.starttime != null) {
          //print("${event.idevent} start time was not null");
          slugEventsResults.add(event);
        } else {
          //print("${event.idevent} null");
        }
      }
    }
    eventResults = slugEventsResults;
    coachResults = slugCoachResults;

    //Remove episodes& seasons from filtered list
    datum.removeWhere(
        (element) => element.episodenum != null || element.seasonnum != null);
    allResults = datum;
    List<Datum> videosSlug = datum
        .where((element) =>
            element.objecttype == ContentModel.content ||
            (element.objecttype == ContentModel.series &&
                element.category != ContentModel.course))
        .toList();
    List<Datum> coursesSlug = datum
        .where((element) => (element.objecttype == ContentModel.series &&
            element.category == ContentModel.course))
        .toList();
    videoResults = videosSlug;
    courseResults = coursesSlug;
    isSearching = false;
    notifyListeners();
    // } catch (noSuchConents) {
    //   print(noSuchConents);
    //   isSearching = false;
    //   allResults = [];
    //   videoResults = [];
    //   courseResults = [];
    //   eventResults = [];
    //   coachResults = [];
    //   notifyListeners();
    // }
  }
}
