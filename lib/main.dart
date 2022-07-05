import 'package:cinepax_flutter/providers/booking_day_state_provider.dart';
import 'package:cinepax_flutter/providers/drawer_state_provider.dart';
import 'package:cinepax_flutter/providers/seats_state_provider.dart';
import 'package:cinepax_flutter/providers/tickets.dart';
import 'package:cinepax_flutter/screens/home_screen.dart';
import 'package:cinepax_flutter/screens/movie_details_screen.dart';
import 'package:cinepax_flutter/screens/payment_screen.dart';
import 'package:cinepax_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/user_auth_screen.dart';
import './providers/movies.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() {
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Movies()),
        ChangeNotifierProvider(
          create: (_) => BookingDayStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SeatsStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Tickets(),
        ),
        ChangeNotifierProvider(
          create: (_) => DrawerStateProvider(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            title: 'Cinepax',
            theme: ThemeData(
              primaryColor: Colors.black,
              fontFamily: 'Poppins-Medium',
            ),
            home: SplashScreen(),
            routes: {
              UserAuthScreen.routeName: (context) => UserAuthScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
              PaymentScreen.routeName: (context) => PaymentScreen(),
            },
          );
        },
      ),
    );
  }
}
