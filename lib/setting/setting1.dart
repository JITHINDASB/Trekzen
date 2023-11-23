import 'package:flutter/material.dart';
import 'package:trekzen/dream_trip/dream.dart';
import 'package:trekzen/home/home.dart';
import 'package:trekzen/setting/inside/logout.dart';
import 'package:trekzen/setting/setting2.dart';
import 'package:trekzen/userprofile/user.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 70.0,
            floating: false,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx2) => const HomeScreen()));
                },
                child: const Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                "Profile",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.black,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    children: [
                      Image.asset(
                        "assets/dp.png",
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TREKZEN",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Trip Plans",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey.shade600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Screen2(
                    color: Colors.black,
                    icon: Icons.person_2_rounded,
                    title: "Edit profile",
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (ctx2) => const UserDataDisplayPage()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Screen2(
                    color: Colors.black,
                    icon: Icons.drafts_rounded,
                    title: "Dream Trips",
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx2) => const Dream()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Screen2(
                    color: Colors.black,
                    icon: Icons.settings,
                    title: "settings",
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx2) => const MyApp1()));
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.support_agent,
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           NextPage()), // Replace NextPage() with the actual widget for the next page
                              // );
                            },
                            child: const Text(
                              "Feel Free to Ask, We're Ready to Help",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
