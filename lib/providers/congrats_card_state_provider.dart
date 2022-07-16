import 'package:flutter/material.dart';

class CongratsCardStateProvider with ChangeNotifier {
  var _showCard = false;

  void showCongratsCard(bool show) {
    _showCard = show;
    notifyListeners();
  }

  bool get shouldShowCongratsCard {
    return _showCard;
  }
}
