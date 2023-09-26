import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

import '../../../core/models/coaches/coach_model/datum.dart';

class InstructorContentCard extends StatelessWidget {
  final bool isMobile;
  final Datum coach;
  const InstructorContentCard(
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
      child: Padding(
        padding: EdgeInsets.all(Constants.insetPadding),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Speaker",
                style: TextStyle(
                    fontSize: Constants.fontSizeMedium,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: Constants.semanticsMarginExSmall,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade500),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(Constants.cardBorderRadius))),
                child: Padding(
                    padding: EdgeInsets.all(Constants.insetPadding),
                    child: isMobile
                        ? getInstructorDescriptionUI(isMobile, coach)
                        : SizedBox(
                            height: 200,
                            child: getInstructorDescriptionUI(isMobile, coach),
                          )),
              ),
            ],
          ),
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
      const SizedBox(width: Constants.cardPadding,),
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
            style: const TextStyle(fontSize: Constants.fontSizeMedium),
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
    if (isMobile) {
      return SizedBox(
        width: 100,
        height: 100,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
              Radius.circular(Constants.cardBorderRadius)),
          child: Image.network(path),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 4 / 5,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(Constants.cardBorderRadius)),
        child: Image.network(path),
      ),
    );
  }
}
