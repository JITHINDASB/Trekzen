import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekzen/home/home.dart';
import 'package:trekzen/slide_screen/slide1.dart';

// ignore: constant_identifier_names
const SAVE_KEY_NAME = "userLoggedIn";

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
      checkLoggedIn();
    });
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

  Future<void> checkLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPrefs.getBool(SAVE_KEY_NAME);
    if (userLoggedIn == null || userLoggedIn == false) {
      const NextPageTwo();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    }
  }
}
