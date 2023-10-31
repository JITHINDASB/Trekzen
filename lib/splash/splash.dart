import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trekzen/slide_screen/slide1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const NextPageTwo()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/Screenshot (128).png',
          height: 200,
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
