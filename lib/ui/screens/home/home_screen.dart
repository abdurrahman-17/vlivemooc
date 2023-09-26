import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';
import 'package:vlivemooc/ui/screens/home/mobile_home.dart';
import 'package:vlivemooc/ui/screens/home/web_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(mobileView: MobileHome(), desktopView: WebHome());
  }
}
