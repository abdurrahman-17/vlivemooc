import 'package:flutter/material.dart';

class WebPlayerProvider with ChangeNotifier {
  String playerUrl = "";
  bool isVisible = false;
  setPlayerUrl({required String playerUrl, required bool isVisible}) {
    this.playerUrl = playerUrl;
    this.isVisible = isVisible;
    notifyListeners();
  }
}
