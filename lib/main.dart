import 'package:cinepax_flutter/providers/booking_day_state_provider.dart';
import 'package:cinepax_flutter/screens/home_screen.dart';
import 'package:cinepax_flutter/screens/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/user_auth_screen.dart';
import './providers/movies.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Movies()),
        ChangeNotifierProvider(
          create: (_) => BookingDayStateProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cinepax',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: UserAuthScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        },
      ),
    );
  }
}
