import 'package:flutter/material.dart';

import '../models/ticket.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _tickets = [];
  List<Ticket> _paymentScreenTickets = [];

  List<Ticket> get getPaymentScreenTickets {
    return [..._paymentScreenTickets];
  }

  List<Ticket> get getTickets {
    if (_tickets.isNotEmpty) {
      _tickets.clear();
      _tickets = [];
    }
    _tickets.insert(
      0,
      Ticket(
        movieTitle: 'KGF 2',
        imagePath: 'assets/images/samples/sample_movie1.png',
        ticketType: TICKET_TYPE.GOLD,
        pricePerTicket: 600,
        quantity: 3,
        location: 'Boulevard Mall, Hyderabad',
        movieTime: '12:00 PM',
        bookingTime: DateTime.now().add(const Duration(days: 2)),
      ),
    );
    _tickets.insert(
      0,
      Ticket(
        movieTitle: 'KGF 2',
        imagePath: 'assets/images/samples/sample_movie1.png',
        ticketType: TICKET_TYPE.PLATINUM,
        pricePerTicket: 600,
        quantity: 2,
        location: 'Boulevard Mall, Hyderabad',
        movieTime: '12:00 PM',
        bookingTime: DateTime.now().add(const Duration(days: 3)),
      ),
    );
    _tickets.insert(
      0,
      Ticket(
        movieTitle: 'Doctor Strange: MOM',
        imagePath: 'assets/images/samples/sample_movie2.png',
        ticketType: TICKET_TYPE.PLATINUM,
        pricePerTicket: 200,
        quantity: 1,
        location: 'Boulevard Mall, Hyderabad',
        movieTime: '04:00 PM',
        bookingTime: DateTime.now().add(const Duration(days: 5)),
      ),
    );
    _tickets.insert(
      0,
      Ticket(
        movieTitle: 'RRR',
        imagePath: 'assets/images/samples/sample_movie3.png',
        ticketType: TICKET_TYPE.GOLD,
        pricePerTicket: 600,
        quantity: 3,
        location: 'Boulevard Mall, Hyderabad',
        movieTime: '04:00 PM',
        bookingTime: DateTime.now().add(const Duration(days: 26)),
      ),
    );
    _tickets.insert(
      0,
      Ticket(
        movieTitle: 'Doctor Strange: MOM',
        imagePath: 'assets/images/samples/sample_movie2.png',
        ticketType: TICKET_TYPE.GOLD,
        pricePerTicket: 600,
        quantity: 3,
        location: 'Boulevard Mall, Hyderabad',
        movieTime: '12:00 PM',
        bookingTime: DateTime.now().add(const Duration(days: 18)),
      ),
    );
    return [..._tickets];
  }

  void bookTicket(Ticket ticket) {
    if (ticket.ticketType == TICKET_TYPE.GOLD) {
      _paymentScreenTickets.insert(
        0,
        Ticket(
            movieTitle: ticket.movieTitle,
            imagePath: ticket.imagePath,
            quantity: ticket.quantity,
            location: ticket.location,
            pricePerTicket: ticket.pricePerTicket,
            ticketType: ticket.ticketType,
            movieTime: ticket.movieTime,
            bookingTime: ticket.bookingTime),
      );
      _paymentScreenTickets.removeWhere((element) =>
          element.ticketType == _paymentScreenTickets[0].ticketType &&
          element.bookingTime.isBefore(_paymentScreenTickets[0].bookingTime));
    } else if (ticket.ticketType == TICKET_TYPE.PLATINUM) {
      _paymentScreenTickets.insert(
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
      _paymentScreenTickets.removeWhere((element) =>
          element.ticketType == _paymentScreenTickets[0].ticketType &&
          element.bookingTime.isBefore(_paymentScreenTickets[0].bookingTime));
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
    _paymentScreenTickets.clear();
    _paymentScreenTickets = [];
    _tickets.clear();
    _tickets = [];
    notifyListeners();
  }
}
