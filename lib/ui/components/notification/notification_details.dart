import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class NotificationCard extends StatelessWidget {
  final String imageBanner;
  final String notificationText;
  final String notificationTiming;
  final bool isWeb;

  const NotificationCard(
      {super.key,
      required this.imageBanner,
      required this.notificationText,
      required this.notificationTiming,
      required this.isWeb});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.insetPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: isWeb ? 120 : 80,
                height: isWeb ? 60 : 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageBanner),
                    fit: BoxFit.cover,
                  ),
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationText,
                        style: TextStyle(
                            fontSize: isWeb ? 18 : 14, fontFamily: "Inter-SemiBold"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(notificationTiming,
                            style: TextStyle(
                                fontSize: isWeb ? 16 : 12,
                                fontFamily: "Inter-SemiBold",
                                color: AppColors.greytextcolor)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: AppColors.greyColor1,
            ),
          )
        ],
      ),
    );
  }
}
