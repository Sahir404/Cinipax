import 'package:flutter/material.dart';
import '../constants/constants.dart';

class YourTicketsComponent extends StatelessWidget {
  final String imagePath;
  final String caption;

  YourTicketsComponent({required this.imagePath, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(imagePath),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            caption,
            style: kHeadlineSmall.copyWith(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
