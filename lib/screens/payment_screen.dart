import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/providers/congrats_card_state_provider.dart';
import 'package:cinepax_flutter/providers/tickets.dart';
import 'package:cinepax_flutter/widgets/billing_item.dart';
import 'package:cinepax_flutter/widgets/payment_screen_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../models/ticket.dart';
import 'package:sizer/sizer.dart';
import '../screens/drawer_screen.dart';

import '../widgets/congrats_card.dart';

class PaymentScreen extends StatelessWidget {
  static const routeName = 'payment-screen/';

  late List<Ticket> _ticketsList;
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
    print('payment screen build called');
    _ticketsList =
        Provider.of<Tickets>(context, listen: false).getPaymentScreenTickets;
    final congratsCardStateProvider =
        Provider.of<CongratsCardStateProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ElevatedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 4),
          backgroundColor: kPaymentScreenTextFieldColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (congratsCardStateProvider.shouldShowCongratsCard) {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: DrawerScreen(fromPaymentScreen: 'Your Tickets'),
                curve: Curves.easeOut,
              ),
            );
          }
          congratsCardStateProvider.showCongratsCard(
              !congratsCardStateProvider.shouldShowCongratsCard);
        },
        child: Consumer<CongratsCardStateProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            return Text(
              provider.shouldShowCongratsCard ? 'Download Tickets' : 'Pay Now',
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: congratsCardStateProvider.shouldShowCongratsCard,
              child: Opacity(
                opacity:
                    congratsCardStateProvider.shouldShowCongratsCard ? 0.3 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Select Payment Method',
                          textAlign: TextAlign.center,
                          style: kHeadlineMedium.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                        // const SizedBox(height: 20),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 100.h - 101,
                            color: kPaymentScreenTextFieldColor,
                          ),
                          SizedBox(
                            height: 100.h - 101,
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification:
                                  (OverscrollIndicatorNotification overscroll) {
                                overscroll.disallowIndicator();
                                return true;
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: const AlwaysScrollableScrollPhysics(),
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
                                        children: [
                                          Container(
                                            width: 100.w,
                                            margin: const EdgeInsets.only(
                                                left: 30, top: 20),
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
                                            textFieldHint:
                                                'Enter card no. here',
                                            marginLeft: 30,
                                            marginRight: 30,
                                          ),
                                          const SizedBox(height: 30),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: PaymentScreenTextField(
                                                  textFieldLabel: 'Expiry date',
                                                  textFieldHint: 'e.g. 12/24',
                                                  marginLeft: 30,
                                                  marginRight: 20,
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                child: PaymentScreenTextField(
                                                  textFieldLabel: 'CV',
                                                  textFieldHint: '- - -',
                                                  marginLeft: 30,
                                                  marginRight: 50,
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
                                      padding: const EdgeInsets.only(top: 20),
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
                                          const SizedBox(height: 30),
                                          ..._ticketsList.map((ticket) {
                                            if (ticket.quantity > 0) {
                                              return BillingItem(
                                                  ticket: ticket);
                                            } else {
                                              return Container();
                                            }
                                          }).toList(),
                                          const SizedBox(height: 60),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            congratsCardStateProvider.shouldShowCongratsCard
                ? CongratsCard()
                : Container(),
          ],
        ),
      ),
    );
  }
}
