import 'package:flutter/material.dart';

class SeatsStateProvider with ChangeNotifier {
  var _showGoldSeats = false;
  var _bookedSeatsGold = <int>[];
  var _bookedSeatsPlat = <int>[];

  void shouldShowGoldSeats(bool show) {
    _showGoldSeats = show;
    notifyListeners();
  }

  bool get showGoldSeats {
    return _showGoldSeats;
  }

  List<int> get getBookedSeats {
    return _showGoldSeats ? [..._bookedSeatsGold] : [..._bookedSeatsPlat];
  }

  void bookSeat(int seatNo) {
    _showGoldSeats
        ? _bookedSeatsGold.add(seatNo)
        : _bookedSeatsPlat.add(seatNo);
    notifyListeners();
  }

  void unBookSeat(int seatNo) {
    _showGoldSeats
        ? _bookedSeatsGold.remove(seatNo)
        : _bookedSeatsPlat.remove(seatNo);
    notifyListeners();
  }
}
