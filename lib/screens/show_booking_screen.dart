import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/widgets/day_widget.dart';
import 'package:cinepax_flutter/widgets/show_dual_buttons.dart';
import 'package:flutter/material.dart';
import '../providers/booking_day_state_provider.dart';
import 'package:provider/provider.dart';

class ShowBookingScreen extends StatelessWidget {
  var size;

  ShowBookingScreen({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
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
            showTopButton: false,
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
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  for (int i = 1; i < 5; i++)
                    Column(
                      children: [
                        Text(i.toString()),
                        Image.asset(
                          'assets/images/unselected_seat.png',
                          width: 80,
                          height: 50,
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  for (int i = 5; i < 9; i++)
                    Column(
                      children: [
                        Text(i.toString()),
                        Image.asset(
                          'assets/images/unselected_seat.png',
                          width: 80,
                          height: 50,
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  for (int i = 9; i < 13; i++)
                    Column(
                      children: [
                        Text(i.toString()),
                        Image.asset(
                          'assets/images/unselected_seat.png',
                          width: 80,
                          height: 50,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
