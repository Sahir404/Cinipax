enum TICKET_TYPE {
  GOLD,
  PLATINUM,
}

class Ticket {
  String movieTitle;
  String imagePath;
  TICKET_TYPE ticketType;
  double pricePerTicket;
  int quantity;
  String location;
  String movieTime;
  DateTime bookingTime;

  Ticket({
    required this.movieTitle,
    required this.imagePath,
    required this.ticketType,
    required this.pricePerTicket,
    required this.quantity,
    required this.location,
    required this.movieTime,
    required this.bookingTime,
  });
}
