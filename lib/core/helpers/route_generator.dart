import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/models/category/category_model/category.dart'
    as categoryobj;
import 'package:vlivemooc/core/models/coaches/coach_model/datum.dart'
    as coaches;
import 'package:vlivemooc/core/models/coaches/events_model/response.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

import '../models/content/content_model/content_model.dart';

class RouteGenerator {
  static String generateContentRoute({required Datum content}) {
    late String base;
    String objectType = content.objecttype!;
    String category = content.category!;
    if (objectType == ContentModel.series) {
      if (category == ContentModel.course) {
        base = AppRouter.courses;
      } else {
        base = AppRouter.series;
      }
    } else {
      base = AppRouter.videos;
    }

    //business/dr-ratanjit-sondhe/an-entrepreneurs-success/media/jxfuu6w7xxxg

    String name =
        (content.title!.replaceAll("?", "")).toLowerCase().replaceAll(" ", "-");
    String tag = "content";
    try {
      // tag = content.tags![0].toString().toLowerCase();
      tag = content.genre!.toLowerCase();
    } catch (error) {
      //do nothing here
    }
    tag = tag.replaceAll(" ", "-");
    String instructor = "default";
    try {
      instructor = content.objectowner!.toLowerCase();
    } catch (error) {
      //do nothing here
    }
    instructor = instructor.replaceAll(" ", "-");

    return "$base/$tag/$instructor/$name/media/${content.objectid}";
  }

  static String generateCoursePlayRoute(
      {required Datum content,
      required String moduleid,
      required String chapterid}) {
    String name = Uri.encodeFull(content.title!);
    return "${AppRouter.courses}/${content.objectid}/$name/$moduleid/$chapterid/play";
  }

  static String generateCoachRoute(
      {required coaches.Datum coach, required String base}) {
    String name = Uri.encodeFull(coach.partnername!);
    return "$base/${coach.partnerid}/$name";
  }

  static String generateEventRoute(
      {required Response event, required String base}) {
    String name = Uri.encodeFull(event.title!);
    return "$base/${event.idevent}/$name";
  }

  static String generateCategoryRoute(
      {required categoryobj.Category category, required String base}) {
    String name = Uri.encodeFull(category.title!);
    return "$base/${category.idgenre!}/$name";
  }

  navigate(BuildContext context, String route, {extra = const {}}) {
    if (kIsWeb) {
      context.go(route, extra: extra);
    } else {
      context.push(route, extra: extra);
    }
  }
}
