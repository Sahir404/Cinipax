import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/models/movie_item.dart';
import 'package:cinepax_flutter/providers/seats_state_provider.dart';
import 'package:cinepax_flutter/providers/tickets.dart';
import 'package:cinepax_flutter/screens/payment_screen.dart';
import 'package:cinepax_flutter/widgets/day_widget.dart';
import 'package:cinepax_flutter/widgets/show_dual_buttons.dart';
import 'package:cinepax_flutter/widgets/show_seating_arrangement.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/ticket.dart';
import '../providers/movies.dart';

class ShowBookingScreen extends StatelessWidget {
  late final MovieItem _currentMovie;

  @override
  Widget build(BuildContext context) {
    final seatsStateProvider =
        Provider.of<SeatsStateProvider>(context, listen: false);
    final ticketsProvider = Provider.of<Tickets>(context, listen: false);
    ticketsProvider.clearTickets();
    seatsStateProvider.resetSelectedSeats();
    _currentMovie = Provider.of<Movies>(context, listen: false).getCenterItem;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 30),
          child: Text(
            'Select Day',
            style: kHeadlineMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 25),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              const SizedBox(width: 30),
              for (int i = 0; i < 7; i++) DayWidget(weekDayIndex: i),
            ],
          ),
        ),
        const SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Select Movie Time',
            style: kHeadlineMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ShowDualButtons(
          showTopButton: seatsStateProvider.showGoldSeats,
          topBtnText: '12:00 PM',
          bottomBtnText: '04:00 PM',
          showBottomPageCallBack: () {
            seatsStateProvider.setTicketTime('noon');
          },
          showTopPageCallBack: () {
            seatsStateProvider.setTicketTime('evening');
          },
          topBtnPadding: 10,
          bottomBtnPadding: 0,
          marginRight: 130,
          marginLeft: 30,
          marginTop: 30,
        ),
        const SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Select Seat/s',
            style: kHeadlineMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Divider(
            color: kPrimaryColor,
            thickness: 1.5,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ShowDualButtons(
            bottomBtnText: 'Gold',
            topBtnText: 'Platinum',
            showTopButton: false,
            showTopPageCallBack: () {
              seatsStateProvider.shouldShowGoldSeats(false);
            },
            showBottomPageCallBack: () {
              seatsStateProvider.shouldShowGoldSeats(true);
            },
            marginRight: 90,
            marginLeft: 90,
            marginTop: 10,
            topBtnPadding: 14,
            bottomBtnPadding: 16,
          ),
        ),
        const SizedBox(height: 10),
        Consumer<SeatsStateProvider>(builder: (context, provider, _) {
          return provider.showGoldSeats
              ? ShowSeatingArrangement()
              : ShowSeatingArrangement();
        }),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Divider(
            color: kPrimaryColor,
            thickness: 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 28, top: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                // populate tickets
                Map<String, List<int>> allSeats =
                    seatsStateProvider.getAllSelectedSeats;
                // if (allSeats['gold']!.isNotEmpty) {
                ticketsProvider.bookTicket(
                  Ticket(
                    movieTitle: _currentMovie.title,
                    imagePath: _currentMovie.imagePath,
                    ticketType: TICKET_TYPE.GOLD,
                    pricePerTicket: 800,
                    quantity: allSeats['gold']!.length,
                    movieTime: seatsStateProvider.getTicketTime,
                    location: 'Boulevard Mall, Hyderabad',
                    bookingTime: DateTime.now(),
                  ),
                );
                // }
                // if (allSeats['plat']!.isNotEmpty) {
                ticketsProvider.bookTicket(
                  Ticket(
                    movieTitle: _currentMovie.title,
                    imagePath: _currentMovie.imagePath,
                    ticketType: TICKET_TYPE.PLATINUM,
                    pricePerTicket: 800,
                    quantity: allSeats['plat']!.length,
                    movieTime: seatsStateProvider.getTicketTime,
                    location: 'Boulevard Mall, Hyderabad',
                    bookingTime: DateTime.now(),
                  ),
                );
                // }
                if (allSeats['gold']!.isEmpty && allSeats['plat']!.isEmpty) {
                  return;
                }
                // navigate to paymentScreen
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: PaymentScreen(),
                    curve: Curves.easeIn,
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                backgroundColor: kPrimaryColor,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Book Now'),
            ),
          ),
        ),
      ],
    );
  }
}
