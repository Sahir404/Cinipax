import 'package:flutter/material.dart';

enum WeekDay { Mon, Tue, Wed, Thurs, Fri, Sat, Sun }


class BookingDayStateProvider with ChangeNotifier {
  final List<WeekDay> _weekDays = [
    WeekDay.Mon,
    WeekDay.Tue,
    WeekDay.Wed,
    WeekDay.Thurs,
    WeekDay.Fri,
    WeekDay.Sat,
    WeekDay.Sun,
  ];

  int _selectedDayIndex = 0;

  List<WeekDay> get getWeekDays {
    return [..._weekDays];
  }

  void setSelectedDayIndex(int dayOfWeek) {
    _selectedDayIndex = dayOfWeek;
    notifyListeners();
  }

  int get getSelectedDayIndex {
    return _selectedDayIndex;
  }

  WeekDay get getSelectedWeekDay {
    return _weekDays[_selectedDayIndex];
  }
  String WeakDay(int i)
  {
    return "${_weekDays[i].name.toString()} 12";
  }
}
