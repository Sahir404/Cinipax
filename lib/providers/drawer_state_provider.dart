import 'package:flutter/material.dart';

class DrawerStateProvider with ChangeNotifier {
  bool _isDrawerOpen = false;

  bool get isDrawerOpen {
    return _isDrawerOpen;
  }

  void openDrawer() {
    _isDrawerOpen = true;
    notifyListeners();
  }

  void closeDrawer() {
    _isDrawerOpen = false;
    notifyListeners();
  }

  double get getXOffset {
    return _isDrawerOpen ? 190 : 0;
  }

  double get getYOffset {
    return _isDrawerOpen ? 160 : 0;
  }

  double get getScaleFactor {
    return _isDrawerOpen ? 0.62 : 1;
  }
}
