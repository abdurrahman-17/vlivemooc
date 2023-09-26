import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/models/coaches/coach_model/datum.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

class CoachCard extends StatelessWidget {
  final Datum coach;
  const CoachCard({super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: InkWell(
          onTap: () {
            RouteGenerator().navigate(
                context,
                RouteGenerator.generateCoachRoute(
                    coach: coach, base: AppRouter.coaches),
                extra: coach);
          },
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: coach.profilepicture,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: AppColors.primaryColor.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.semanticsMarginExSmall,
                            vertical: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              coach.partnername!,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: Constants.fontSizeMedium,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              coach.countryname ?? "",
                              style: const TextStyle(
                                fontSize: Constants.fontSizeSmall,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
/*
SizedBox(
        width: 150,
        child: InkWell(
          onTap: () {},
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              width: double.infinity,
              height: 190,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
                child: Image.network(
                  coach.profilepicture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: Constants.semanticMarginDefault,
            ),
            Text(
              coach.partnername!,
              style: const TextStyle(
                  fontSize: Constants.fontSizeMedium,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
      */
