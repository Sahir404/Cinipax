import 'package:cinepax_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  static const routeName = 'payment-screen/';

  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Select Payment Method',
                style: kHeadlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
