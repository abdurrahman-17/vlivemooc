import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/components/account/login_prompt.dart';
import 'package:vlivemooc/ui/components/app_version/app_version.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar_without_icon.dart';
import 'package:vlivemooc/ui/components/auth/basic_information.dart';
import 'package:vlivemooc/ui/components/auth/change_password.dart';
import 'package:vlivemooc/ui/components/auth/delete_account.dart';
import 'package:vlivemooc/ui/components/cards/my_plans.dart';
import 'package:vlivemooc/ui/components/mylearnings/my_watchhistory.dart';
import 'package:vlivemooc/ui/components/purchase/purchase_history.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';
import 'package:vlivemooc/ui/screens/account/mobile_account.dart';
import 'package:vlivemooc/ui/screens/account/web_account.dart';
import 'package:vlivemooc/ui/screens/bottomnav/my_learnings.dart';

import '../../../core/provider/user_provider.dart';

class Account extends StatefulWidget {
  final bool isMobile;
  const Account({super.key, this.isMobile = false});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int selected = 0;
  onChange(index) {
    setState(() {
      selected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isMobile) {
      navItems = [
        "Basic Information",
        "Change Password",
        "Purchase History",
        "My Plans",
        "Delete Account"
      ];
      items = [
        BasicInformation(
          isMobile: widget.isMobile,
        ),
        const ChangePassword(),
        const PurchaseHistory(),
        MyPlans(
          isMobile: widget.isMobile,
        ),
        const DeleteAccount()
      ];
    } else {
      items = [
        BasicInformation(
          isMobile: widget.isMobile,
        ),
        const MyLearnings(
          isMobile: false,
        ),
        const ChangePassword(),
        const MyWatchHistory(
          isWatchHistory: false,
          isMobile: false,
        ),
        const MyWatchHistory(
          isMobile: false,
          isWatchHistory: true,
        ),
        const PurchaseHistory(),
        MyPlans(
          isMobile: widget.isMobile,
        ),
        const DeleteAccount()
      ];

      navItems = [
        "Basic Information",
        "My Learnings",
        "Change Password",
        "Watchlist",
        "Watch History",
        "Purchase History",
        "My Plans",
        "Delete Account"
      ];
    }
  }

  late List<Widget> items;
  late List<String> navItems;

  @override
  Widget build(BuildContext context) {
    bool isLoggedin = Provider.of<UserProvider>(context).isLoggedIn;
    if (!isLoggedin) {
      return const Scaffold(
        appBar: MobileAppBarWithoutIcon(title: Constants.myAccount,),
        body: LoginPrompt(message: "Please login to see your account"),
        bottomSheet: AppVersion(),
      );
    }
    return Responsive(
      mobileView: MobileAccount(
        onNavChange: onChange,
        selectedNavItem: selected,
        items: items,
        renderWidget: items[selected],
        navItems: navItems,
      ),
      desktopView: WebAccount(
        onNavChange: onChange,
        selectedNavItem: selected,
        renderWidget: items[selected],
        navItems: navItems,
      ),
    );
  }
}
