import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';
import 'package:vlivemooc/ui/components/account/login_prompt.dart';
import 'package:vlivemooc/ui/components/mylearnings/my_watchhistory.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../../core/provider/user_provider.dart';
import '../../components/appbar/mobile_app_bar_without_icon.dart';
import '../../constants/string_constants.dart';
import 'my_coachings.dart';
import 'my_courses.dart';

class MyLearningsMobile extends StatefulWidget {
  const MyLearningsMobile({super.key});

  @override
  State<MyLearningsMobile> createState() => _MyLearningsMobileState();
}

class _MyLearningsMobileState extends State<MyLearningsMobile>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserProvider>(context).isLoggedIn;

    return Scaffold(
        appBar: const MobileAppBarWithoutIcon(
          title: StringConstants.myLearnings,
        ),
        body: isLoggedIn
            ? Container(
                color: AppColors.greyColor5,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TabBar(
                      controller: tabController,
                      onTap: (index) {
                        //Control tabs accordingly
                        setState(() {
                          tabController.index = index;
                        });
                      },
                      indicatorColor: AppColors.buttonTextBlue,
                      labelColor: AppColors.blackcolor,
                      unselectedLabelColor: AppColors.textLight1,
                      labelStyle: poppinsBold(14, AppColors.blackcolor),
                      unselectedLabelStyle:
                          poppinsMedium(14, AppColors.textLight1),
                      tabs: const [
                        Tab(text: "Courses"),
                        Tab(text: "Coaching"),
                        Tab(text: "Watch History"),
                      ],
                    ),
                    Container(
                      color: AppColors.textLight1,
                      height: 0.25,
                    ),
                    Flexible(
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          MyCourses(
                            isVideos: false,
                            isMobile: true,
                          ),
                          MyCoachings(),
                          MyWatchHistory(
                            isMobile: true,
                            isWatchHistory: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const LoginPrompt(message: "Please login to see your learnings"));
  }
}
