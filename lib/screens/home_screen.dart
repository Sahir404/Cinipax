import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import '../constants/constants.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        // top: false,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/samples/sample_movie1.png',
                    height: size.height * 0.63,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  BlurryContainer(
                    width: double.infinity,
                    height: size.height * 0.63,
                    blur: 8,
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.zero),
                    child: const Text(''),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/cinepax_logo.png',
                width: 130,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 6),
              const Text(
                'Upcoming movies',
                style: kHeadlineMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
