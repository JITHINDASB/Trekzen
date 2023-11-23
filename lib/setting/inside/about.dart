import 'package:flutter/material.dart';
import 'package:trekzen/setting/inside/logout.dart';

class MyAbout extends StatelessWidget {
  const MyAbout({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx2) => const MyApp1()));
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text('About App'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TREKZEN',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Developed by\n\nJITHINDAS B",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Version 1.0.1',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
