import 'package:flutter/material.dart';

class BottomNavProvider with ChangeNotifier {
  int activeIndex = 0;
  changePage(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
