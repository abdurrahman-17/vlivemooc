import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/carousel/carousel.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/coaches/upcoming_sessions.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/components/layout/coach_layout.dart';
import 'package:vlivemooc/ui/components/layout/content_layout.dart';
import 'package:vlivemooc/ui/components/layout/events_layout.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

import '../../../core/helpers/rebuilder.dart';
import '../../screens/continue_learning/continue_learning.dart';

class Home extends StatelessWidget {
  final bool isMobile;
  final RebuildController rebuildController = RebuildController();

  Home({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // isMobile
          //     ? MobileTopBar(
          //         logoPath: "assets/images/logo_white.png",
          //         backgroundColor: AppColors.primaryColor,
          //       )
          //     : Container(),
          // const SizedBox(
          //   height: Constants.semanticsMarginExSmall,
          // ),
          // isMobile ? const MobileNavButons() : Container(),
          // const SizedBox(
          //   height: Constants.semanticsMarginExSmall,
          // ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          const Carousel(),
          const SizedBox(
            height: Constants.fontSizeDefault,
          ),
          Categories(
            renderScrollButtons: !isMobile,
          ),
          const ContinueLearning(
              title: Constants.continueJourney, isOnlyVidoes: false),

          const UpcomingSessions(),
          const ContentLayout(
            title: "Popular in videos",
            listType: "FEATURED",
            objectType: "",
            categoryType: "",
            renderEmpty: true,
            showAll: AppRouter.videos,
          ),
          const SizedBox(
            height: Constants.fontSizeDefault,
          ),
          const ContentLayout(
            title: "Top Courses",
            listType: "",
            objectType: "SERIES",
            renderEmpty: true,
            categoryType: '["COURSE"]',
            showAll: AppRouter.courses,
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          const EventsLayout(
            showAll: AppRouter.events,
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          const CoachLayout(),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),

          //isMobile ? Container() : const Testimonials(),
          isMobile ? Container() : const WebFooter()
        ],
      ),
    );
  }
}
