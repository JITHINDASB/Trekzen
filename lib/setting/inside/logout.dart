import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekzen/log_sign/login.dart';
import 'package:trekzen/setting/inside/about.dart';
import 'package:trekzen/setting/inside/privacy.dart';
import 'package:trekzen/setting/inside/terms&condition.dart';
import 'package:trekzen/setting/setting1.dart';
import 'package:trekzen/splash/splash.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx2) => const Settings()));
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const MyBody(),
      ),
    );
  }
}

class MyBody extends StatelessWidget {
  const MyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Privacy()),
                (Route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Privacy Policy',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const TermsCondition()),
                (Route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Terms and conditions',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyAbout()),
                (Route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'About',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Back'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signout(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text('Logout',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  signout(BuildContext ctx) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(SAVE_KEY_NAME, false);
    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => Signin()), (route) => false);
  }
}
