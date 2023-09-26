import 'package:flutter/material.dart';

import '../../../core/models/coaches/coach_model/datum.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../cards/tag_card.dart';

class TagsListView extends StatelessWidget {
  final List<String>? tags;
  const TagsListView({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return tags != null
        ? SizedBox(
            height: 25,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: tags!.length,
                itemBuilder: (BuildContext context, int index) {
                  return TagCard(tag: tags![index]);
                }),
          )
        : Container();
  }
}

List<dynamic> coachStatistics = [
  {'title': 'TOTAL STUDENTS', 'description': '900'},
  {'title': 'TOTAL COURSES', 'description': '10'},
  {'title': 'RATING', 'description': '4.6'},
  {'title': 'REVIEWS', 'description': '34,454'},
];
List<dynamic> coachStatisticsMobile = [
  {'title': 'TOTAL STUDENTS', 'description': '900'},
  {'title': 'TOTAL COURSES', 'description': '10'},
];

class StatisticsListView extends StatelessWidget {
  final bool isMobile;
  const StatisticsListView({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              isMobile ? coachStatisticsMobile.length : coachStatistics.length,
          itemBuilder: (BuildContext context, int index) {
            var data = coachStatistics[index];
            return StatisticsLayout(
              title: data['title'],
              description: data['description'],
              isMobile: isMobile,
            );
          }),
    );
  }
}

class StatisticsLayout extends StatelessWidget {
  final String title;
  final String description;
  final bool isMobile;
  const StatisticsLayout(
      {super.key,
      required this.title,
      required this.description,
      this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: isMobile
                      ? Constants.fontSizeSmall
                      : Constants.fontSizeMedium),
            ),
            Text(
              description,
              style: TextStyle(
                  fontSize: isMobile
                      ? Constants.fontSizeMedium
                      : Constants.fontSizeLarge,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          width: Constants.insetPadding,
        ),
        const VerticalDivider(
          width: 2,
        ),
        SizedBox(
          width: Constants.insetPadding,
        ),
      ],
    );
  }
}

class ImageLayout extends StatelessWidget {
  final String path;
  const ImageLayout({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(Constants.cardBorderRadius)),
        child: Image.network(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class TitleLayout extends StatelessWidget {
  final Datum coach;
  final bool isMobile;
  const TitleLayout({super.key, required this.coach, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coach.partnername!,
              style: const TextStyle(
                  fontSize: Constants.fontSizeLarge,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: Constants.semanticsMarginExSmall,
            ),
            Text(
              coach.countryname ?? "",
              style: TextStyle(
                  fontSize: Constants.fontSizeSmall,
                  color: AppColors.primaryColor),
            )
          ],
        )),
        // isMobile ? Container() : const SocialLinks()
      ],
    );
  }
}

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/facebookimage.png',
          height: 30,
          width: 30,
          color: Colors.grey,
        ),
        const SizedBox(
          width: Constants.semanticsMarginExSmall,
        ),
        Image.asset(
          'assets/images/instagramimage.png',
          height: 30,
          width: 30,
          color: Colors.grey,
        ),
        const SizedBox(
          width: Constants.semanticsMarginExSmall,
        ),
        Image.asset(
          'assets/images/twitterimage.png',
          height: 30,
          width: 30,
          color: Colors.grey,
        ),
        const SizedBox(
          width: Constants.semanticsMarginExSmall,
        ),
        Image.asset(
          'assets/images/linkedinimage.png',
          height: 30,
          width: 30,
          color: Colors.grey,
        ),
      ],
    );
  }
}
