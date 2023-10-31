import 'package:flutter/material.dart';
import 'package:trekzen/log_sign/login.dart';
import 'package:trekzen/setting/inside/about.dart';
import 'package:trekzen/setting/inside/privacy.dart';
import 'package:trekzen/setting/inside/terms&condition.dart';
import 'package:trekzen/setting/setting1.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx2) => Settings()));
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.white, // White app bar
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: MyBody(),
      ),
    );
  }
}

class MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        Container(
          height: 60, // Adjust the height as needed
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Privacy()),
                (Route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Black button background
            ),
            child: Text(
              'Privacy Policy',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 60, // Adjust the height as needed
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => TermsCondition()),
                (Route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Black button background
            ),
            child: Text(
              'Terms and conditions',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 60, // Adjust the height as needed
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyAbout()),
                (Route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Black button background
            ),
            child: Text(
              'About',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 60, // Adjust the height as needed
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Back'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          // Perform logout actions here
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx2) => Signin()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // OK button background
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Black button background
            ),
            child: Text('Logout',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}
