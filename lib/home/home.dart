import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekzen/homelist/homelist.dart';
import 'package:trekzen/setting/setting1.dart';
import 'package:trekzen/trip_create/create.dart';
import 'package:trekzen/trip_create/search.dart';
import 'package:trekzen/trip_create/view.dart';

class HomeScreen extends StatefulWidget {
  final String? name;

  const HomeScreen({super.key, this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexNum = 0;
  late String _name;

  @override
  void initState() {
    super.initState();
    _loadName();
    // getallUser();
    _name = widget.name ?? "User";
  }

  void _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? 'User';
    setState(() {
      _name = name;
    });
  }

  // Define your pages here
  final List<Widget> pages = [
    const HomeScreen(),
    const ScreenAdd(),
    const ScreenHome(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/dp.png"),
                // Set your profile picture asset here
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Make your trip plan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
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
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10.0),
              //   child: Text(
              //     'Ongoing Trips',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Expanded(
                child: HomeList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              tooltip: 'Home',
              label: "Home",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.create_new_folder_outlined),
              tooltip: 'Create',
              label: "create",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.pageview),
              tooltip: 'My trips',
              label: "my trips",
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              tooltip: 'profile',
              label: "Profile",
              backgroundColor: Colors.blue),
        ],
        iconSize: 30,
        currentIndex: indexNum,
        onTap: (int index) {
          setState(() {
            indexNum = index;
          });

          // Use Navigator to navigate to the selected page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => pages[index],
            ),
          );
        },
      ),
    );
  }
}
