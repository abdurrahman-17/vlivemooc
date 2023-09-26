import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/coaches/events_model/response.dart';

class VideoModel {
  String title,
      imageUrl,
      country,
      instructor,
      instructorImage =
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
      noOfEpisodes,
      price,
      totalHours,
      noOfModules,
      videoType,
      currency = "₹";
  int liveDate;
  String description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet dui eget odio ultricies lacinia in et risus. Nullam non mi non ex consequat sodales. Donec vel aliquam nulla. Sed pharetra justo eu massa eleifend ultrices. Nulla facilisi. Proin id velit vitae libero pharetra dictum.';

  double progress = getRandomDecimalValue(0.0, 1.0);
  List<String> genres, youWillLearn;
  List<VideoDescriptionPoints> videDescriptionPoints;
  Response eventData;
  VideoModel({
    required this.title,
    required this.imageUrl,
    required this.country,
    required this.instructor,
    required this.noOfEpisodes,
    required this.price,
    required this.totalHours,
    required this.noOfModules,
    required this.videoType,
    required this.liveDate,
    required this.genres,
    required this.youWillLearn,
    required this.videDescriptionPoints,
    required this.eventData,
  });
}

double getRandomDecimalValue(double minValue, double maxValue) {
  var random = Random();
  return minValue + random.nextDouble() * (maxValue - minValue);
}

class VideoDescriptionPoints {
  IconData icon;
  String description;

  VideoDescriptionPoints({required this.icon, required this.description});
}

List<VideoDescriptionPoints> videoDescriptionPoints = [
  VideoDescriptionPoints(
      icon: Icons.play_circle_outline, description: "5 Chapters"),
  VideoDescriptionPoints(
      icon: Icons.folder_outlined, description: "4 Downloadable Reasources"),
  VideoDescriptionPoints(
      icon: Icons.question_mark_outlined, description: "5 Quiz"),
  VideoDescriptionPoints(
      icon: Icons.play_circle_outline, description: "Full Lifetime Access"),
  VideoDescriptionPoints(
      icon: Icons.play_circle_outline,
      description: "Certificate of Completion"),
];
