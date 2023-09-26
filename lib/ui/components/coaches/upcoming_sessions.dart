import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/coaches/coach_model/instructor_sessions.dart';
import '../../../core/models/coaches/coach_model/session_datum.dart';
import '../cards/session_card.dart';

class UpcomingSessions extends StatefulWidget {
  const UpcomingSessions({super.key});

  @override
  State<UpcomingSessions> createState() => _UpcomingSessionsState();
}

class _UpcomingSessionsState extends State<UpcomingSessions> {
  List<SessionDatum> sessions = [];
  List<SessionDatum> events = [];

  @override
  void initState() {
    super.initState();
    getSessions();
  }

  getSessions() async {
    bool isLoggedin =
        Provider.of<UserProvider>(context, listen: false).isLoggedIn;
    if (isLoggedin) {
      InstructorSessions sessionData = await NetworkHandler.getSessions();
      List<SessionDatum> slug1 = [];
      List<SessionDatum> slug2 = [];
      for (var i = 0; i < sessionData.sessionData!.length; i++) {
        SessionDatum datum = sessionData.sessionData![i];
        if (datum.type == "WEBINAR") {
          slug1.add(datum);
        } else {
          slug2.add(datum);
        }
      }
      setState(() {
        sessions = slug2;
        events = slug1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty && events.isEmpty) {
      return Container();
    }
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(
          horizontal: Constants.insetPadding, vertical: Constants.insetPadding),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sessions.isNotEmpty
              ? const Text(
                  "Upcoming Session's",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              : Container(),
          sessions.isNotEmpty
              ? const SizedBox(
                  height: 20,
                )
              : Container(),
          sessions.isNotEmpty
              ? SizedBox(
                  height: 190,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: sessions.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SessionCard(
                          sessionData: sessions[index],
                        );
                      }),
                )
              : Container(),
          events.isEmpty
              ? const SizedBox(
                  height: 20,
                )
              : Container(),
          events.isNotEmpty
              ? const Text(
                  "Upcoming Event's",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              : Container(),
          events.isNotEmpty
              ? const SizedBox(
                  height: 20,
                )
              : Container(),
          events.isNotEmpty
              ? SizedBox(
                  height: 190,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: events.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SessionCard(
                          sessionData: events[index],
                        );
                      }),
                )
              : Container(),
        ],
      ),
    );
  }
}
