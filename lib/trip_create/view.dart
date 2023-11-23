import 'package:flutter/material.dart';
import 'package:trekzen/db_model/database/db.dart';
import 'package:trekzen/home/home.dart';
import 'package:trekzen/trip_create/list.dart';
import 'package:trekzen/trip_create/search.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    getallUser();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx2) => const HomeScreen()));
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Trip Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: ScreenSearch(),
                );
              },
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => ScreenAdd()));
      //   },
      //   tooltip: 'Add Student',
      //   child: const Icon(Icons.add),
      // ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListDataWidget(),
        ),
      ),
    );
  }
}
