import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar.dart';

import '../../components/coaches/coaches.dart';

class MobileCoaches extends StatelessWidget {
  const MobileCoaches({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
          appBar: MobileAppBar(
            title: "Coaches",
          ),
          body: Coaches()),
    );
  }
}
