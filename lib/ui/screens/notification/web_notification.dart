import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/components/notification/notification_details.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class WebNotification extends StatelessWidget {
  const WebNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return const NotificationCard(
                  imageBanner: "assets/images/sliderimage.png",
                  notificationText:
                  "Lorem ipsum dolor sit amet consetestur sadipscing elitr sed",
                  notificationTiming: "12:00 AM",
                  isWeb: true,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
