import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/events/events.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar.dart';

class MobileEvents extends StatelessWidget {
  const MobileEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
          appBar: MobileAppBar(
            title: "Events",
          ),
          body: Events()),
    );
  }
}
