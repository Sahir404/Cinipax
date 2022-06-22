import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/widgets/payment_screen_text_field.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  height: size.height - 101,
                  color: kPaymentScreenTextFieldColor,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            const SizedBox(height: 40),
                            PaymentScreenTextField(
                              textFieldLabel: 'Name on card',
                              textFieldHint: 'Enter name here',
                              marginLeft: 30,
                              marginRight: 30,
                            ),
                            const SizedBox(height: 30),
                            PaymentScreenTextField(
                              textFieldLabel: 'Card No.',
                              textFieldHint: 'Enter card no. here',
                              marginLeft: 30,
                              marginRight: 30,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  child: PaymentScreenTextField(
                                    textFieldLabel: 'Expiry date',
                                    textFieldHint: 'e.g. 12/24',
                                    marginLeft: 30,
                                    marginRight: 0,
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: PaymentScreenTextField(
                                    textFieldLabel: 'CV',
                                    textFieldHint: '-  -  -  -',
                                    marginLeft: 30,
                                    marginRight: 30,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Billing',
                              style: kHeadlineMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // const SizedBox(height: 200),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
