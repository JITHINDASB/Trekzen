import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:trekzen/db_model/database/db.dart';
import 'package:trekzen/db_model/model.dart';
import 'package:trekzen/trip_create/profile.dart';

enum AmountFilter {
  below500,
  between500And5000,
  above5000,
  all,
}

enum DateFilter {
  all,
  last7Days,
  last30Days,
  customDate,
}

class HomeList extends StatefulWidget {
  const HomeList({Key? key});

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final List<Color> cardColors = [
    Colors.lightBlue,
    Colors.green,
    Colors.orange,
    Colors.red,
    // Add more colors as needed
  ];
  AmountFilter _filter = AmountFilter.all;
  DateFilter _dateFilter = DateFilter.all;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UserModel>>(
      valueListenable: UserListNotifier,
      builder: (BuildContext ctx, List<UserModel> userList, Widget? child) {
        if (userList.isEmpty) {
          return Center(
            child: Text(
              "No trips  planned yet!!..",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AutofillHints.creditCardType),
            ),
          );
        } else {
          var filteredList = userList.where((user) {
            switch (_filter) {
              case AmountFilter.below500:
                var amount = int.tryParse(user.amount ?? '');
                return amount != null && amount < 500;
              case AmountFilter.between500And5000:
                var amount = int.tryParse(user.amount ?? '');
                return amount != null && amount >= 500 && amount <= 5000;
              case AmountFilter.above5000:
                var amount = int.tryParse(user.amount ?? '');
                return amount != null && amount > 5000;
              default:
                return true;
            }
          }).where((user) {
            // Date Filter
            var userDate = DateTime.parse(
                user.start ?? ''); // Assuming start date is a string
            switch (_dateFilter) {
              case DateFilter.customDate:
                return (_startDate == null || userDate.isAfter(_startDate!)) &&
                    (_endDate == null || userDate.isBefore(_endDate!));
              case DateFilter.last7Days:
                return userDate
                    .isAfter(DateTime.now().subtract(Duration(days: 7)));
              case DateFilter.last30Days:
                return userDate
                    .isAfter(DateTime.now().subtract(Duration(days: 30)));
              default:
                return true;
            }
          }).toList();

          var ongoingTrips = <UserModel>[];
          var upcomingTrips = <UserModel>[];

          for (var user in filteredList) {
            var userDate = DateTime.parse(user.start ?? '');
            if (userDate.isAfter(DateTime.now())) {
              upcomingTrips.add(user);
            } else {
              ongoingTrips.add(user);
            }
          }

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        DropdownButton<AmountFilter>(
                          value: _filter,
                          items: AmountFilter.values.map((filter) {
                            return DropdownMenuItem<AmountFilter>(
                              value: filter,
                              child: Text(
                                filter.toString().split('.').last,
                                style:
                                    TextStyle(fontSize: 12), // Adjust font size
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _filter = value!;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10, // Reduced width
                        ),

                        // Date Filter Dropdown
                        DropdownButton<DateFilter>(
                          value: _dateFilter,
                          items: DateFilter.values.map((filter) {
                            return DropdownMenuItem<DateFilter>(
                              value: filter,
                              child: Text(
                                filter.toString().split('.').last,
                                style:
                                    TextStyle(fontSize: 12), // Adjust font size
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _dateFilter = value!;
                              if (_dateFilter == DateFilter.customDate) {
                                _showDateRangePicker();
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 10, // Reduced width
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showDeleteAllConfirmationDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // Background color
                            onPrimary: Colors.white, // Text color
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12), // Adjust padding
                          ),
                          child: Text(
                            "Delete All",
                            style: TextStyle(fontSize: 12), // Adjust font size
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Ongoing Trips',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ongoingTrips.length,
                  itemBuilder: (ctx, indexVal) {
                    final userdata = ongoingTrips[indexVal];
                    final randomIndex = Random().nextInt(cardColors.length);

                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx1) {
                          return ScreenProfile(
                            name: userdata.name,
                            phone: userdata.phone,
                            nametwo: userdata.nametwo,
                            address: userdata.adress,
                            start: userdata.start,
                            end: userdata.end,
                            amount: userdata.amount,
                            expense: userdata.expense,
                            dropdown: userdata.dropdown,
                            photo: userdata.photo,
                            index: indexVal,
                          );
                        }));
                      },
                      child: Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 5,
                        color: cardColors[randomIndex],
                        child: Container(
                          height: 120, // Adjust the height as needed
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10.0),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(File(userdata.photo)),
                            ),
                            title: Text(
                              "${userdata.nametwo}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow
                                  .ellipsis, // Handle overflow with ellipsis
                            ),
                            subtitle: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "${userdata.start}",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow with ellipsis
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.airport_shuttle_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    "${userdata.end}",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow with ellipsis
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                if (indexVal != null) {
                                  popupDialogueBox(indexVal);
                                } else {
                                  print('ID passed is null');
                                }
                              },
                              icon: Icon(Icons.delete),
                              tooltip: 'Delete trips',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Upcoming Trips',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: upcomingTrips.length,
                  itemBuilder: (ctx, indexVal) {
                    final userdata = upcomingTrips[indexVal];
                    final randomIndex = Random().nextInt(cardColors.length);

                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx1) {
                          return ScreenProfile(
                            name: userdata.name,
                            phone: userdata.phone,
                            nametwo: userdata.nametwo,
                            address: userdata.adress,
                            start: userdata.start,
                            end: userdata.end,
                            amount: userdata.amount,
                            expense: userdata.expense,
                            dropdown: userdata.dropdown,
                            photo: userdata.photo,
                            index: indexVal,
                          );
                        }));
                      },
                      child: Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 5,
                        color: cardColors[randomIndex],
                        child: Container(
                          height: 100,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10.0),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(File(userdata.photo)),
                            ),
                            title: Text(
                              "${userdata.nametwo}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow
                                  .ellipsis, // Handle overflow with ellipsis
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "${userdata.start}",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow
                                      .ellipsis, // Handle overflow with ellipsis
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.airport_shuttle_rounded, // Plane icon
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "${userdata.end}",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow
                                      .ellipsis, // Handle overflow with ellipsis
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                if (indexVal != null) {
                                  popupDialogueBox(indexVal);
                                } else {
                                  print('ID passed is null');
                                }
                              },
                              icon: Icon(Icons.delete),
                              tooltip: 'Delete trips',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<void> _showDateRangePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        if (_startDate != null &&
            _endDate != null &&
            _startDate!.isAfter(_endDate!)) {
          DateTime temp = _startDate!;
          _startDate = _endDate;
          _endDate = temp;
        }
      });
    }
  }

  void popupDialogueBox(int indexValue) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Do you want to delete this entry?"),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 16,
          ),
          actionsOverflowButtonSpacing: 20,
          actions: [
            ElevatedButton(
              onPressed: () {
                deleteUser(indexValue);
                Navigator.of(context).pop();
              },
              child: Text("YES"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("NO"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteAllConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete All Data?"),
          content: Text("Are you sure you want to delete all data?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                deleteAllData();
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.black), // Set button background color to black
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Set text color to white
              ),
              child: Text("Delete All"),
            )
          ],
        );
      },
    );
  }

  void deleteAllData() {
    // Call the function to delete all data from the database
    deleteAllUsers();
  }
}
