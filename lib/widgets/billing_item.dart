import 'package:cinepax_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../models/ticket.dart';

class BillingItem extends StatelessWidget {
  final Ticket ticket;

  BillingItem({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.h,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(110),
            child: Image.asset(
              ticket.imagePath,
              width: 110,
              height: 110,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  ticket.movieTitle,
                  style: kHeadlineSmall.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('Quantity : ${ticket.quantity}x'),
                Text('Type : ${ticket.ticketType.name}'),
                Text('Price : ${ticket.pricePerTicket * ticket.quantity}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
