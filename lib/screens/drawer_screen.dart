import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            DrawerScreenDetails(),
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}

class DrawerScreenDetails extends StatelessWidget {
  const DrawerScreenDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
