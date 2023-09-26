import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../constants/constants.dart';

class MobileAppBarWithoutIcon extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final Widget? titleWidget;
  const MobileAppBarWithoutIcon(
      {super.key,
      this.title,
      this.preferredSize = const Size.fromHeight(Constants.mobileAppBarHeight),
      this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: Constants.appBarElevation,
      title: titleWidget ?? Text(title!),
    );
  }
}
