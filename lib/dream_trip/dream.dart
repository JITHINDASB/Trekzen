import 'package:flutter/material.dart';
import 'package:trekzen/db_model/dream_database/drm_db.dart';
import 'package:trekzen/dream_trip/dreamdisplay.dart';
import 'package:trekzen/dream_trip/dreamsearch.dart';
import 'package:trekzen/setting/setting1.dart';

class Dream extends StatefulWidget {
  const Dream({super.key});

  @override
  State<Dream> createState() => _DreamState();
}

class _DreamState extends State<Dream> {
  bool isLoading = true; // Flag to track whether data is loading or not

  @override
  void initState() {
    super.initState();
    loadData(); // Load data when the widget is initialized
  }

  Future<void> loadData() async {
    await getalldata();
    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    getalldata();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dream Trips',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx2) => Settings()));
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back, // Back icon
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: DreamSearch(),
                );
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: DreamDisplay(),
        ),
      ),
    );
  }
}
