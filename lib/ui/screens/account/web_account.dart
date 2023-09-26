import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/account/account_nav.dart';
import 'package:vlivemooc/ui/components/account/account_section.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../constants/colors.dart';

class WebAccount extends StatelessWidget {
  final Function onNavChange;
  final int selectedNavItem;
  final List<String> navItems;
  final Widget renderWidget;
  const WebAccount(
      {super.key,
      required this.onNavChange,
      required this.selectedNavItem,
      required this.navItems,
      required this.renderWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: AccountNav(
                onTap: onNavChange,
                navItems: navItems,
                selectedItem: selectedNavItem,
              )),
          Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(Constants.insetPadding),
                child: Card(
                  elevation: Constants.cardElevation,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Constants.cardBorderRadius))),
                  child: AccountSection(
                    title: navItems[selectedNavItem],
                    child: renderWidget,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
