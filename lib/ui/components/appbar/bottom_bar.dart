import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../constants/constants.dart';

class BottomBar extends StatelessWidget {
  final Function onItemTapped;
  final int activeIndex;
  const BottomBar(
      {super.key, required this.onItemTapped, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(
                16,
              ))),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomBarItem(
              icon: Icons.home,
              label: "Home",
              index: 0,
              activeIndex: activeIndex,
              onItemTapped: onItemTapped,
            ),
            BottomBarItem(
              icon: Icons.search,
              label: "Search",
              index: 1,
              activeIndex: activeIndex,
              onItemTapped: onItemTapped,
            ),
            BottomBarItem(
              icon: Icons.list_alt,
              label: "My Learnings",
              index: 2,
              activeIndex: activeIndex,
              onItemTapped: onItemTapped,
            ),
            BottomBarItem(
              icon: Icons.bookmark_outline,
              label: "Watchlist",
              index: 3,
              activeIndex: activeIndex,
              onItemTapped: onItemTapped,
            ),
            BottomBarItem(
              icon: Icons.person_outline,
              label: "Account",
              index: 4,
              activeIndex: activeIndex,
              onItemTapped: onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int activeIndex;
  final Function onItemTapped;
  const BottomBarItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.index,
      required this.activeIndex,
      required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemTapped(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            color: activeIndex == index
                ? AppColors.primaryColor
                : Colors.white.withOpacity(0),
            borderRadius: const BorderRadius.all(
                Radius.circular(Constants.cardBorderRadius))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                icon,
                color: activeIndex == index ? Colors.white : Colors.black,
              ),
              activeIndex == index
                  ? const SizedBox(
                      width: Constants.semanticsMarginExSmall,
                    )
                  : Container(),
              activeIndex == index
                  ? Text(
                      label,
                      style: const TextStyle(color: Colors.white),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
