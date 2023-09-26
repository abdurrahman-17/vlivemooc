import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/text_styles.dart';
import '../../../core/provider/user_provider.dart';
import '../../constants/colors.dart';
import '../account/login_prompt.dart';
import 'my_coachings.dart';
import 'my_courses.dart';

class MyLearningsWeb extends StatefulWidget {
  const MyLearningsWeb({super.key});

  @override
  State<MyLearningsWeb> createState() => _MyLearningsWebState();
}

class _MyLearningsWebState extends State<MyLearningsWeb>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserProvider>(context).isLoggedIn;
    return isLoggedIn
        ? Column(
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
                      isMobile: false,
                    ),
                    MyCoachings(),

                  ],
                ),
              )
            ],
          )
        : const LoginPrompt(message: "Please login to see your learnings");
  }
}
