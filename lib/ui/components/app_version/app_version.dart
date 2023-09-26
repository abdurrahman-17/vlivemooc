import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.semanticMarginTen),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text(
          appVersion,
          textAlign: TextAlign.center,
          style:
          poppinsMedium(Constants.fontSizeMedium, AppColors.blackcolor)
      )]),
    );
  }

  String appVersion = "";

  getAppVersion() {
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        appVersion = "V${value.version}";
      });
    });
  }
@override
  void didChangeDependencies() {
  getAppVersion();
    super.didChangeDependencies();

  }
}
