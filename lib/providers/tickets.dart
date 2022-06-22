import 'package:flutter/material.dart';

import '../models/ticket.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _tickets = [];

  List<Ticket> get getTickets {
    return [..._tickets];
  }

  void bookTicket(Ticket ticket) {
    if (ticket.ticketType == TICKET_TYPE.GOLD) {
      _tickets.insert(
          0,
          Ticket(
              movieTitle: ticket.movieTitle,
              imagePath: ticket.imagePath,
              quantity: ticket.quantity,
              location: ticket.location,
              pricePerTicket: ticket.pricePerTicket,
              ticketType: ticket.ticketType,
              movieTime: ticket.movieTime,
              bookingTime: ticket.bookingTime));
      _tickets.removeWhere((element) =>
          element.ticketType == _tickets[0].ticketType &&
          element.bookingTime.isBefore(_tickets[0].bookingTime));
    } else if (ticket.ticketType == TICKET_TYPE.PLATINUM) {
      _tickets.insert(
          0,
          Ticket(
              movieTitle: ticket.movieTitle,
              imagePath: ticket.imagePath,
              quantity: ticket.quantity,
              location: ticket.location,
              pricePerTicket: ticket.pricePerTicket,
              ticketType: ticket.ticketType,
              movieTime: ticket.movieTime,
              bookingTime: ticket.bookingTime));
      _tickets.removeWhere((element) =>
          element.ticketType == _tickets[0].ticketType &&
          element.bookingTime.isBefore(_tickets[0].bookingTime));
    }
    notifyListeners();
  }

  double get getTotal {
    double total = 0.0;
    for (var ticket in _tickets) {
      total += ticket.pricePerTicket;
    }
    return total;
  }

  void clearTickets() {
    if (_tickets.isEmpty) return;
    _tickets.clear();
    _tickets = [];
    // notifyListeners();
  }
}
