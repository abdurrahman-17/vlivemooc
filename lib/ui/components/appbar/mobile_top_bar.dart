import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/components/buttons/accounts_button.dart';
import 'package:vlivemooc/ui/components/buttons/live_tv_button.dart';
import 'package:vlivemooc/ui/components/buttons/login_button.dart';
import 'package:vlivemooc/ui/components/buttons/notifications_button.dart';

import '../../../core/provider/user_provider.dart';
import '../../constants/constants.dart';

class MobileTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final Color backgroundColor;
  @override
  final Size preferredSize;

  const MobileTopBar(
      {super.key,
      required this.logoPath,
      this.preferredSize = const Size.fromHeight(Constants.appBarHeight),
      this.backgroundColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserProvider>(context).isLoggedIn;

    return AppBar(
      toolbarHeight: Constants.appBarHeight,
      backgroundColor: backgroundColor,
      elevation: Constants.appBarElevation,
      title: Row(
        children: [
          isLoggedIn ? const AccountsButton(isMobile:true) : const LoginButton(),
          const Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LiveTvButton(),
              NotificationsButton(),
              /*SizedBox(
                width: Constants.semanticsMarginExSmall,
              ),*/
            ],
          )),
        ],
      ),
    );
  }
}
