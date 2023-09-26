import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/screens/Events/mobile_events.dart';
import 'package:vlivemooc/ui/screens/events/web_events.dart';

import '../../responsive/responsive.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileView: MobileEvents(), desktopView: WebEvents());
  }
}
