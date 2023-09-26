import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../constants/constants.dart';
import '../../routes/Routes.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final Widget? titleWidget;
  const MobileAppBar(
      {super.key,
      this.title,
      this.preferredSize = const Size.fromHeight(Constants.mobileAppBarHeight),
      this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: Constants.appBarElevation,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRouter.home);
          }
        },
      ),
      title: titleWidget ?? Text(title!),
    );
  }
}
