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

class ListDataWidget extends StatefulWidget {
  const ListDataWidget({Key? key});

  @override
  State<ListDataWidget> createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<ListDataWidget> {
  final List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
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
          return const Center(
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
                var amount = int.tryParse(user.amount);
                return amount != null && amount < 500;
              case AmountFilter.between500And5000:
                var amount = int.tryParse(user.amount);
                return amount != null && amount >= 500 && amount <= 5000;
              case AmountFilter.above5000:
                var amount = int.tryParse(user.amount);
                return amount != null && amount > 5000;
              default:
                return true;
            }
          }).where((user) {
            var userDate = DateTime.parse(user.start);
            switch (_dateFilter) {
              case DateFilter.customDate:
                return (_startDate == null || userDate.isAfter(_startDate!)) &&
                    (_endDate == null || userDate.isBefore(_endDate!));
              case DateFilter.last7Days:
                return userDate
                    .isAfter(DateTime.now().subtract(const Duration(days: 7)));
              case DateFilter.last30Days:
                return userDate
                    .isAfter(DateTime.now().subtract(const Duration(days: 30)));
              default:
                return true;
            }
          }).toList();

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
                                style: const TextStyle(
                                    fontSize: 12), // Adjust font size
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _filter = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<DateFilter>(
                          value: _dateFilter,
                          items: DateFilter.values.map((filter) {
                            return DropdownMenuItem<DateFilter>(
                              value: filter,
                              child: Text(
                                filter.toString().split('.').last,
                                style: const TextStyle(fontSize: 12),
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
                        const SizedBox(
                          width: 10, // Reduced width
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showDeleteAllConfirmationDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                          child: const Text(
                            "Delete All",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (ctx, indexVal) {
                    final userdata = filteredList[indexVal];
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
                        margin: const EdgeInsets.all(10.0),
                        elevation: 5,
                        color: cardColors[randomIndex],
                        child: SizedBox(
                          height: 100,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10.0),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(File(userdata.photo)),
                            ),
                            title: Text(
                              userdata.nametwo,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  userdata.start,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.airport_shuttle_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  userdata.end,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // ignore: unnecessary_null_comparison
                                if (indexVal != null) {
                                  popupDialogueBox(indexVal);
                                } else {
                                  print('ID passed is null');
                                }
                              },
                              icon: const Icon(Icons.delete),
                              tooltip: 'Delete trips',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: filteredList.length,
                ),
              )
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
          title: const Text("Do you want to delete this entry?"),
          titleTextStyle: const TextStyle(
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
              child: const Text("YES"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("NO"),
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
          title: const Text("Delete All Data?"),
          content: const Text("Are you sure you want to delete all data?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                deleteAllData();
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text("Delete All"),
            )
          ],
        );
      },
    );
  }

  void deleteAllData() {
    deleteAllUsers();
  }
}
