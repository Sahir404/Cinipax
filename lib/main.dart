import 'package:cinepax_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import './screens/user_auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinepax',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: UserAuthScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
