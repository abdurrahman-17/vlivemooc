import 'package:flutter/material.dart';
import '../../components/events/event_detail.dart';
import '../../responsive/responsive.dart';

class EventDetailScreen extends StatelessWidget {
  final String idevent;
  const EventDetailScreen({super.key, required this.idevent});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobileView: EventDetail(
          isMobile: true,
          idevent: idevent,
        ),
        desktopView: EventDetail(
          isMobile: false,
          idevent: idevent,
        ));
  }
}
