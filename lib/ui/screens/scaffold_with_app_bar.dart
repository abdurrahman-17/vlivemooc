import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

class ScaffoldWithAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  const ScaffoldWithAppBar(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: AppColors.primaryColor,
        ),
        body: child,
      ),
    );
  }
}
