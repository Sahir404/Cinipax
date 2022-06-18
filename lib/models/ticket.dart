enum TICKET_TYPE {
  GOLD,
  PLATINUM,
}

class Ticket {
  String movieTitle;
  TICKET_TYPE ticketType;
  double price;
  String location;
  String time;

  Ticket({
    required this.movieTitle,
    required this.ticketType,
    required this.price,
    required this.location,
    required this.time,
  });
}
