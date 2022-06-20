import 'package:cinepax_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = 'payment-screen/';

  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Widget> images = [
    Image.asset(
      'assets/images/payment_cards/credit_card.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/payment_cards/easypaisa_card.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/payment_cards/jazz_cash_card.png',
      fit: BoxFit.fill,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Select Payment Method',
              textAlign: TextAlign.center,
              style: kHeadlineMedium.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: Swiper(
                itemBuilder: (context, index) {
                  return images[index];
                },
                onIndexChanged: (index) {
                  // print(index);
                },
                itemCount: 3,
                itemWidth: 230.0,
                itemHeight: 180.0,
                layout: SwiperLayout.STACK,
                loop: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
