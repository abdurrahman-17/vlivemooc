import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar.dart';
import 'package:vlivemooc/ui/components/notification/notification_details.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class MobileNotification extends StatelessWidget {
  const MobileNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobileAppBar(title: "Notifications"),
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
                  isWeb: false,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
