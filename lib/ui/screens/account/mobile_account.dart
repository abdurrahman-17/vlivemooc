import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/account/account_nav.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar_without_icon.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/screens/scaffold_with_app_bar.dart';

class MobileAccount extends StatelessWidget {
  final Function onNavChange;
  final int selectedNavItem;
  final List<String> navItems;
  final Widget renderWidget;
  final List<Widget> items;
  const MobileAccount(
      {super.key,
        required this.onNavChange,
        required this.selectedNavItem,
        required this.navItems,
        required this.items,
        required this.renderWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobileAppBarWithoutIcon(title:Constants.myAccount),
      body: AccountNav(
        onTap: (index) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ScaffoldWithAppBar(
                title: navItems[index],
                child: Padding(
                    padding: EdgeInsets.all(Constants.insetPadding),
                    child: items[index]));
          }));
        },
        navItems: navItems,
        selectedItem: 100,
      ),
    );
  }
}


/*
Column(
      children: [
        SizedBox(
          height: 310,
          child: AccountNav(
            onTap: onNavChange,
            navItems: navItems,
            selectedItem: selectedNavItem,
          ),
        ),
        Expanded(
          flex: 1,
          child: AccountSection(
            title: navItems[selectedNavItem],
            child: renderWidget,
          ),
        ),
      ],
    );
    */