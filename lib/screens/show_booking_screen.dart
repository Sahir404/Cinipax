import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/providers/seats_state_provider.dart';
import 'package:cinepax_flutter/screens/payment_screen.dart';
import 'package:cinepax_flutter/widgets/day_widget.dart';
import 'package:cinepax_flutter/widgets/show_dual_buttons.dart';
import 'package:cinepax_flutter/widgets/show_seating_arrangement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowBookingScreen extends StatelessWidget {
  var size;

  ShowBookingScreen({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final seatsStateProvider =
        Provider.of<SeatsStateProvider>(context, listen: false);
    seatsStateProvider.resetSelectedSeats();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 40),
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
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 60),
          child: ShowDualButtons(
            showTopButton: seatsStateProvider.showGoldSeats,
            size: size,
            topBtnText: '12:00 PM',
            bottomBtnText: '04:00 PM',
            showBottomPageCallBack: () {},
            showTopPageCallBack: () {},
            horizontalPadding: 0,
            horizontalMargin: 30,
          ),
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
            size: size,
            bottomBtnText: 'Gold',
            topBtnText: 'Platinum',
            showTopButton: false,
            showTopPageCallBack: () {
              seatsStateProvider.shouldShowGoldSeats(false);
            },
            showBottomPageCallBack: () {
              seatsStateProvider.shouldShowGoldSeats(true);
            },
            horizontalMargin: size.width * 0.18,
            horizontalPadding: 0,
          ),
        ),
        Consumer<SeatsStateProvider>(builder: (context, provider, _) {
          return provider.showGoldSeats
              ? ShowSeatingArrangement(size: size)
              : ShowSeatingArrangement(size: size);
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
                Navigator.of(context).pushNamed(PaymentScreen.routeName);
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
