import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/provider/bottom_nav_provider.dart';
import 'package:vlivemooc/ui/components/appbar/bottom_bar.dart';
import 'package:vlivemooc/ui/components/home/home_mobile.dart';

import 'package:vlivemooc/ui/screens/bottomnav/account.dart';
import 'package:vlivemooc/ui/screens/bottomnav/my_learnings.dart';
import 'package:vlivemooc/ui/screens/search/search_screen.dart';

import '../../components/mylearnings/my_watchhistory.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  onItemTapped(index) {
    Provider.of<BottomNavProvider>(context, listen: false).changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    int activeIndex = Provider.of<BottomNavProvider>(context).activeIndex;
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        body: IndexedStack(
          index: activeIndex,
          children: const <Widget>[
            // Home(
            //   isMobile: true,
            // ),
            HomeMobile(),
            SearchScreen(),
            MyLearnings(
              isMobile: true,
            ),
            MyWatchHistory(isMobile: true, isWatchHistory: false),
            Account(
              isMobile: true,
            )
          ],
        ),
        bottomNavigationBar: BottomBar(
          activeIndex: activeIndex,
          onItemTapped: onItemTapped,
        ),
      ),
    );
  }
}
