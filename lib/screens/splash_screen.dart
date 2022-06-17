import 'package:cinepax_flutter/screens/user_auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash-screen/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: -2.0,
      upperBound: 1.0,
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    // navigate to userAthScreen/homeScreen
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: UserAuthScreen(),
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final additionalSize = size.height - 215;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/splash_background.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              // fit: BoxFit.fitWidth,
            ),
            SizedBox(
              width: double.infinity,
              height: size.height - _controller.value * additionalSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/cinepax_logo.png',
                    width: 236,
                    height: 216,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
