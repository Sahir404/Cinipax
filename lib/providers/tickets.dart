import 'package:flutter/material.dart';

import '../models/ticket.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _tickets = [];

  List<Ticket> get getTickets {
    return [..._tickets];
  }

  void addTicket(Ticket ticket) {
    _tickets.add(ticket);
    notifyListeners();
  }

  double get getTotal {
    double total = 0.0;
    for (var ticket in _tickets) {
      total += ticket.price;
    }
    return total;
  }
}
