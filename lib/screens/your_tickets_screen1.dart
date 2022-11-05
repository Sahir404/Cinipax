import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/providers/tickets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/movie_item.dart';
import '../providers/movies.dart';
import '../providers/seats_state_provider.dart';
import '../widgets/your_tickets_component.dart';

class YourTicketsScreen extends StatefulWidget {
  const YourTicketsScreen({Key? key}) : super(key: key);

  @override
  State<YourTicketsScreen> createState() => _YourTicketsScreenState();
}

class _YourTicketsScreenState extends State<YourTicketsScreen> {
  int _index = 0;
  final CarouselController _controller = CarouselController();


  @override
  Widget build(BuildContext context) {
    final MovieItem  _currentMovie = Provider.of<Movies>(context, listen: false).getCenterItem;
    final tickets = Provider.of<Tickets>(context, listen: false).getTickets;
    final seatsStateProvider =
    Provider.of<SeatsStateProvider>(context, listen: false);
    final ticketsProvider = Provider.of<Tickets>(context, listen: false);
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
            children: [
              Text(
                'Your Tickets',
                style: kHeadlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 40),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      _currentMovie.imagePath,
                      width: 92.w,
                      height: 68.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 10,
                    right: 10,
                    child: BlurryContainer(
                      borderRadius: BorderRadius.circular(18),
                      blur: 25,
                      color: Colors.white.withOpacity(0.4),
                      height: 30.h,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: CarouselSlider.builder(
                                  itemBuilder: (context, index, realIndex) {
                                    return Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _currentMovie.title,
                                              style: kHeadlineSmall.copyWith(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 14),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                'assets/images/icons/icon_location.png'),
                                            const SizedBox(width: 5),
                                            Text(tickets[1].location),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            YourTicketsComponent(
                                              imagePath:
                                                  'assets/images/icons/icon_seats.png',
                                              caption:
                                                  '${seatsStateProvider.getAllSelectedSeats[TicketType(context)]} Seat/s',
                                            ),
                                            YourTicketsComponent(
                                              imagePath:
                                                  'assets/images/icons/icon_ticket_type.png',
                                              caption: TicketType(context)
                                              ,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            YourTicketsComponent(
                                              imagePath:
                                                  'assets/images/icons/icon_date.png',
                                              caption: DateFormat('dd - LLL')
                                                  .format(tickets[_index]
                                                      .bookingTime),
                                            ),
                                            YourTicketsComponent(
                                                imagePath:
                                                    'assets/images/icons/icon_time.png',
                                                caption:
                                                seatsStateProvider.getTicketTime),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: tickets.length,
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                    autoPlay: false,
                                    scrollPhysics:
                                        const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    initialPage: 0,
                                    viewportFraction: 1,
                                    enableInfiniteScroll: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _index = index;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: tickets.mapIndexed((index, ticket) {
                                  return Container(
                                    width: _index == index ? 23 : 22,
                                    height: _index == index ? 7 : 6,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: _index == index
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _index == index
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 0.7,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          // Positioned(
                          //   left: 0,
                          //   child: IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         if (_index == 0) {
                          //           _index = tickets.length - 1;
                          //           return;
                          //         }
                          //         _index--;
                          //       });
                          //       _controller.jumpToPage(_index);
                          //     },
                          //     icon: Image.asset(
                          //         'assets/images/icons/arrow_previous.png'),
                          //   ),
                          // ),
                          // Positioned(
                          //   right: 0,
                          //   child: IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         if (_index == tickets.length - 1) {
                          //           _index = 0;
                          //           return;
                          //         }
                          //         _index++;
                          //       });
                          //       _controller.jumpToPage(_index);
                          //     },
                          //     icon: Image.asset(
                          //       'assets/images/icons/arrow_next.png',
                          //     ),
                          //   ),
                          // ),
                        ],
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
  String TicketType( BuildContext context ) {
    final seatsStateProvider =
    Provider.of<SeatsStateProvider>(context, listen: false);
    if(seatsStateProvider.showGoldSeats){
      return "gold";
    }
    else {
      return "platinium";
    }

}
}
