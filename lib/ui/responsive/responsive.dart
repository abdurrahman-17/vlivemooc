import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobileView;
  final Widget desktopView;
  const Responsive(
      {super.key, required this.mobileView, required this.desktopView});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return mobileView;
        }
        return desktopView;
      },
    );
  }
}
