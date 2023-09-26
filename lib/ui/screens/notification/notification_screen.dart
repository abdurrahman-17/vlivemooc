import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';
import 'package:vlivemooc/ui/screens/notification/mobile_notification.dart';
import 'package:vlivemooc/ui/screens/notification/web_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(mobileView: MobileNotification(), desktopView: WebNotification());
  }
}
