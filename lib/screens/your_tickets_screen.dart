import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cinepax_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class YourTicketsScreen extends StatelessWidget {
  const YourTicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/auth_screen_background.png',
          height: 100.h,
          fit: BoxFit.fitHeight,
        ),
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Tickets',
                style: kHeadlineMedium,
              ),
              const SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/samples/sample_movie2.png',
                      width: 92.w,
                      height: 66.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 10,
                    right: 10,
                    child: BlurryContainer(
                      borderRadius: BorderRadius.circular(10),
                      blur: 25,
                      color: Colors.white.withOpacity(0.4),
                      height: 30.h,
                      child: Column(
                        children: [],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 4),
                  backgroundColor: kPaymentScreenTextFieldColor,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text('Download Ticket'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
