import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/providers/booking_day_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayWidget extends StatelessWidget {
  final int weekDayIndex;
  late List<WeekDay> weekDays;

  DayWidget({required this.weekDayIndex});

  @override
  Widget build(BuildContext context) {
    final stateProvider = Provider.of<BookingDayStateProvider>(context);
    weekDays = stateProvider.getWeekDays;
    return GestureDetector(
      onTap: () {
        stateProvider.setSelectedDayIndex(weekDayIndex);
      },
      child: Container(
        width: 80,
        height: 110,
        margin: const EdgeInsets.only(right: 20, bottom: 8, top: 5),
        decoration: BoxDecoration(
          border: stateProvider.getSelectedDayIndex == weekDayIndex
              ? null
              : Border.all(
                  color: kPrimaryColor,
                  width: 3,
                ),
          color: stateProvider.getSelectedDayIndex == weekDayIndex
              ? kDayCardBackground
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: stateProvider.getSelectedDayIndex == weekDayIndex
                  ? const Offset(5, 4)
                  : const Offset(2, 2),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              weekDays[weekDayIndex].name,
              style: kHeadlineSmall.copyWith(
                color: stateProvider.getSelectedDayIndex == weekDayIndex
                    ? Colors.white
                    : kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '13-05',
              style: kHeadlineSmall.copyWith(
                color: stateProvider.getSelectedDayIndex == weekDayIndex
                    ? Colors.white
                    : kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
