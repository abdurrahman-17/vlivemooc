import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:vlivemooc/ui/constants/colors.dart';

import '../../../core/models/coaches/coach_model/session_datum.dart';
import '../helpers/link_launcher_web.dart';

class SessionCard extends StatelessWidget {
  final SessionDatum sessionData;
  const SessionCard({super.key, required this.sessionData});

  formatTime(String date) {
    "2023-06-15T19:00:00.000Z";
    // String time = (date.split("T")[1]).split(".")[0];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(width: 1, color: Colors.grey)),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sessionData.title != null
                  ? Text(
                      sessionData.title!.isNotEmpty
                          ? sessionData.title!
                          : "Coaching session",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      "Coaching session",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month),
                      sessionData.starttime != null
                          ? Text(
                              DateFormat.MEd().format(sessionData.starttime!))
                          : Container()
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer),
                      sessionData.starttime != null
                          ? Text(DateFormat('hh:mm a')
                              .format(sessionData.starttime!))
                          : Container()
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  LinkLauncherWeb()
                      .launchUrlWeb(sessionData.joinUrl, newTab: true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primaryColor, // This is what you need!
                ),
                child: const Text("Join"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
