import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trekzen/dream_trip/dream.dart';
import 'package:trekzen/dream_trip/dreamupdate.dart';

class DreamProfile extends StatefulWidget {
  final String name;

  final String nametwo;
  final String address;
  final String photo;
  final String phone;
  final String start;
  final String end;
  final String amount;
  final String expense;
  final String dropdown;

  final int index;

  const DreamProfile(
      {super.key,
      required this.name,
      required this.phone,
      required this.nametwo,
      required this.address,
      required this.start,
      required this.end,
      required this.amount,
      required this.expense,
      required this.dropdown,
      required this.photo,
      required this.index});

  @override
  State<DreamProfile> createState() => _DreamProfileState();
}

class _DreamProfileState extends State<DreamProfile> {
  @override
  Widget build(BuildContext context) {
    // getallUser();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          ' Details of dream trips',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx2) => const Dream()));
              },
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Details of ${widget.nametwo} trip',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: FileImage(
                        File(
                          widget.photo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        ' from:\t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'to: \t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.nametwo,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Phone Number:\t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.phone,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Address:\t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.address,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Starting Date:\t',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.start,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ), // Add some spacing between the columns
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ending Date:\t',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.end,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Travel in:\t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.dropdown,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Amount :\t',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '₹ ',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.amount,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Expense:\t',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '₹ ',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.expense,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return DreamUpdate(
                            name: widget.name,
                            phone: widget.phone,
                            nametwo: widget.nametwo,
                            address: widget.address,
                            start: widget.start,
                            end: widget.end,
                            amount: widget.amount,
                            expense: widget.expense,
                            dropdown: widget.dropdown,
                            photo: widget.photo,
                            index: widget.index,
                          );
                        }),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.black, // Set background color to black
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
