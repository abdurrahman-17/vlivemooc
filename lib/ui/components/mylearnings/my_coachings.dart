import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/coaches/coach_model/instructor_sessions.dart';
import '../../../core/models/coaches/coach_model/session_datum.dart';
import '../../../core/network/network_handler.dart';
import '../../../core/provider/user_provider.dart';
import '../../animations/loading_animation.dart';
import '../../constants/string_constants.dart';
import 'my_coaching_card.dart';

class MyCoachings extends StatefulWidget {
  const MyCoachings({super.key});

  @override
  State<MyCoachings> createState() => _MyCoachingsState();
}

class _MyCoachingsState extends State<MyCoachings> {
  int expandedTileIndex = 0;
  List<SessionDatum> sessions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //Call the APi to fetch the upcoming coachings
    getSessions();
  }

  getSessions() async {
    bool isLoggedin =
        Provider.of<UserProvider>(context, listen: false).isLoggedIn;
    if (isLoggedin) {
      try {
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
            isLoading = false;
          });

      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: LoadingAnimation(),
      );
    }

    if (sessions.isEmpty) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          StringConstants.emptySession,
          style: poppinsBold(15, AppColors.textLight1),
        ),
      ));
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: radiusAll8(context),
                  color: AppColors.whiteColor,
                  border: Border.all(color: const Color(0xffDDDFE1), width: 1)),
              child: MyCoachingCard(
                  sessionData: sessions[index], isMobile: isMobile(context)),
            ));
      },
      itemCount: sessions.length,
    );
  }
}
