import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';
import '../../routes/routes.dart';

class LogoButton extends StatelessWidget {
  final String assetURI;
  const LogoButton({super.key, required this.assetURI});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(AppRouter.home);
      },
      child: SizedBox(width: Constants.logoWidth, child: Image.asset(assetURI)),
    );
  }
}
