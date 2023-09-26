import 'package:flutter/material.dart';

class ResponsiveStateProvider with ChangeNotifier {
  int deviceWidth = 600;
  int deviceHeight = 600;
  bool isMobile = false;
  double pageMargin = 20;

  setResponseiveState(int width, int height, bool mobile, double margin) {
    deviceHeight = width;
    deviceHeight = height;
    isMobile = mobile;
    pageMargin = margin;
    notifyListeners();
  }
}
