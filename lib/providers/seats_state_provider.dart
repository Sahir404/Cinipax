import 'package:flutter/material.dart';

class SeatsStateProvider with ChangeNotifier {
  var _showGoldSeats = false;
  var _bookedSeatsGold = <int>[1, 2, 3, 10, 12, 30, 31, 40, 41, 42, 43];
  var _bookedSeatsPlat = <int>[3, 4, 6, 32, 14, 12];
  var _selectedSeatsPlat = <int>[];
  var _selectedSeatsGold = <int>[];
  var _ticketTime = '04:00 PM';

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

  void selectSeat(int seatNo) {
    _showGoldSeats
        ? _selectedSeatsGold.add(seatNo)
        : _selectedSeatsPlat.add(seatNo);
    notifyListeners();
  }

  void unBookSeat(int seatNo) {
    _showGoldSeats
        ? _bookedSeatsGold.remove(seatNo)
        : _bookedSeatsPlat.remove(seatNo);
    notifyListeners();
  }

  void unSelectSeat(int seatNo) {
    _showGoldSeats
        ? _selectedSeatsGold.remove(seatNo)
        : _selectedSeatsPlat.remove(seatNo);
    notifyListeners();
  }

  List<int> get getSelectedSeats {
    return _showGoldSeats ? _selectedSeatsGold : _selectedSeatsPlat;
  }

  Map<String, List<int>> get getAllSelectedSeats {
    return {
      'gold': _selectedSeatsGold,
      'plat': _selectedSeatsPlat,
    };
  }

  void resetSelectedSeats() {
    if (_selectedSeatsGold.isEmpty && _selectedSeatsPlat.isEmpty) return;
    _selectedSeatsPlat = <int>[];
    _selectedSeatsGold = <int>[];
    // notifyListeners();
  }

  void setTicketTime(String time) {
    _ticketTime = time == 'noon' ? '12:00 PM' : '04:00 PM';
    notifyListeners();
  }

  String get getTicketTime {
    return _ticketTime;
  }
}
