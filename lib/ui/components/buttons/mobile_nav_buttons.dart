import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../constants/constants.dart';
import '../../routes/Routes.dart';

class MobileNavButons extends StatelessWidget {
  const MobileNavButons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constants.insetPadding),
      child: SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            // const NavButtonLinks(route: AppRouter.home, label: "Home"),
            // SizedBox(
            //   width: Constants.insetPadding,
            // ),
            const NavButtonLinks(route: AppRouter.videos, label: "Videos"),
            SizedBox(
              width: Constants.insetPadding,
            ),
            const NavButtonLinks(route: AppRouter.courses, label: "Courses"),
            SizedBox(
              width: Constants.insetPadding,
            ),
            const NavButtonLinks(route: AppRouter.coaches, label: "Coaching"),
            SizedBox(
              width: Constants.insetPadding,
            ),
            const NavButtonLinks(route: AppRouter.events, label: "Events"),
          ],
        ),
      ),
    );
  }
}

class NavButtonLinks extends StatelessWidget {
  final String route;
  final String label;
  const NavButtonLinks({super.key, required this.route, required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(color: AppColors.primaryColor)),
      onPressed: () {
        context.push(route);
      },
      child: Text(label),
    );
  }
}
