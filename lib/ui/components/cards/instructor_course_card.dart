import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

import '../../../core/models/coaches/coach_model/datum.dart';

class InstructorCourseCard extends StatelessWidget {
  final bool isMobile;
  final Datum coach;
  const InstructorCourseCard(
      {super.key, required this.isMobile, required this.coach});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteGenerator().navigate(
            context,
            RouteGenerator.generateCoachRoute(
                coach: coach, base: AppRouter.coaches),
            extra: coach);
      },
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade500),
              borderRadius: const BorderRadius.all(
                  Radius.circular(Constants.cardBorderRadius))),
          child: Padding(
              padding: EdgeInsets.all(Constants.insetPadding),
              child: getInstructorDescriptionUI(isMobile, coach)),
        ),
      ),
    );
  }
}

Widget getInstructorDescriptionUI(bool isMobile, Datum coach) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      InstructorImage(isMobile: isMobile, path: coach.profilepicture),
      const SizedBox(
        width: Constants.semanticsMarginExSmall,
      ),
      Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            coach.partnername!,
            style: const TextStyle(
                fontSize: Constants.fontSizeLarge, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          Text(
            coach.countryname ?? "",
            style: TextStyle(
                fontSize: Constants.fontSizeSmall,
                color: AppColors.primaryColor),
          ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          Text(
            coach.description!,
            style: const TextStyle(fontSize: Constants.fontSizeSmall),
          ),
        ],
      ))
    ],
  );
}

class InstructorImage extends StatelessWidget {
  final bool isMobile;
  final String path;
  const InstructorImage(
      {super.key, required this.isMobile, required this.path});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: Image.network(path),
      ),
    );
  }
}
