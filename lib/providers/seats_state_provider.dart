import 'package:flutter/material.dart';

class SeatsStateProvider with ChangeNotifier {
  var _showGoldSeats = false;
  var _daySelected = 0;
  var _bookedSeatsGold = <int>[1, 2, 3, 10, 12, 30, 31, 40, 41, 42, 43];
  var _bookedSeatsGoldDay1 = <int>[1, 2, 3, 10,  30, 31, 40, 41, 42];
  var _bookedSeatsGoldDay2 = <int>[1, 3, 12, 31, 40, 41, 42, 43];
  var _bookedSeatsGoldDay3 = <int>[1, 3, 10, 31, 40, 41, 42, 43];
  var _bookedSeatsGoldDay4 = <int>[1, 10, 12, 31, 40, 41, 42, 43,30];
  var _bookedSeatsGoldDay5 = <int>[1, 3,  12, 31, 40, 41, 42, 43];
  var _bookedSeatsGoldDay6 = <int>[1, 3, 10, 12, 31, 40,  42, 43];
  var _bookedSeatsGoldDay7 = <int>[1, 3, 10, 12, 31, 41, 42, 43];



  var _bookedSeatsPlatDay1 = <int>[1, 2, 3, 10, 12, 15,  30, 31, 40, 41, 42];
  var _bookedSeatsPlatDay2 = <int>[1, 3, 10, 31, 39 ,41, 42, 43];
  var _bookedSeatsPlatDay3 = <int>[1, 3, 12, 31, 40, 41, 42, 43];
  var _bookedSeatsPlatDay4 = <int>[1, 10, 12, 31, 16, 41, 42, 43,30];
  var _bookedSeatsPlatDay5 = <int>[1, 3,  12, 31, 17, 18, 41, 42, 43];
  var _bookedSeatsPlatDay6 = <int>[1, 3, 10, 19, 31, 40,  42, 43];
  var _bookedSeatsPlatDay7 = <int>[1, 3, 10, 11, 21, 22, 23, 31, 41, 42, 43];
  var _bookedSeatsPlat = <int>[3, 4, 6, 32, 14, 12];
  var _selectedSeatsPlat = <int>[];
  var _selectedSeatsGold = <int>[];
  var _ticketTime = '04:00 PM';

  void shouldShowGoldSeats(bool show) {
    _showGoldSeats = show;
    notifyListeners();
  }
  void daySelected(int day) {
   _daySelected = day;
    notifyListeners();
  }


  bool get showGoldSeats {
    return _showGoldSeats;
  }

  List<int> get getBookedSeats {
    return _showGoldSeats ? [..._bookedSeatsGold] : [..._bookedSeatsPlat];
  }
  List<int> get getDayBookedSeatsGold {
    if(_daySelected==0)
      {
        return _bookedSeatsGoldDay1;
      }
    else if(_daySelected==1)
      {
        return _bookedSeatsGoldDay2;
      }
    else if(_daySelected==2)
    {
      return _bookedSeatsGoldDay3;
    }
    else if(_daySelected==3)
    {
      return _bookedSeatsGoldDay4;
    }
    else if(_daySelected==4)
    {
      return _bookedSeatsGoldDay5;
    }
    else if(_daySelected==5)
    {
      return _bookedSeatsGoldDay6;
    }
    else if(_daySelected==6)
    {
      return _bookedSeatsGoldDay7;
    }
    else{
      return _bookedSeatsGold;
    }
  }
  List<int> get getDayBookedSeatsPlat {
    if(_daySelected==0)
    {
      return _bookedSeatsPlatDay1;
    }
    else if(_daySelected==1)
    {
      return _bookedSeatsPlatDay2;
    }
    else if(_daySelected==2)
    {
      return _bookedSeatsPlatDay3;
    }
    else if(_daySelected==3)
    {
      return _bookedSeatsPlatDay4;
    }
    else if(_daySelected==4)
    {
      return _bookedSeatsPlatDay5;
    }
    else if(_daySelected==5)
    {
      return _bookedSeatsPlatDay6;
    }
    else if(_daySelected==6)
    {
      return _bookedSeatsPlatDay7;
    }
    else{
      return _bookedSeatsGold;
    }
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
      'platinium': _selectedSeatsPlat,
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
