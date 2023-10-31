import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trekzen/db_model/dream_database/drm_db.dart';
import 'package:trekzen/db_model/model.dart';
import 'package:trekzen/dream_trip/dreamprofile.dart';

class DreamDisplay extends StatefulWidget {
  const DreamDisplay({super.key});

  @override
  State<DreamDisplay> createState() => _DreamDisplayState();
}

class _DreamDisplayState extends State<DreamDisplay> {
  final List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    // Add more colors as needed
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      //here studentListNotifier is the valuenotifier object
      valueListenable: dreamListNotifier,
      builder: (BuildContext ctx, List<DreamModel> DreamList, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, indexVal) {
            //studentdata used to fetch each student's data from student list one by one
            final userdata = DreamList[indexVal];
            final randomIndex = Random().nextInt(cardColors.length);

            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (ctx1) {
                  return DreamProfile(
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow
                          .ellipsis, // Handle overflow with ellipsis
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "${userdata.start}",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
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
                              fontSize: 10, fontWeight: FontWeight.bold),
                          overflow: TextOverflow
                              .ellipsis, // Handle overflow with ellipsis
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (indexVal != null) {
                          DreamBox(indexVal);
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
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: DreamList.length,
        );
      },
    );
  }

  DreamBox(int indexValue) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Do you want to delete this entry?"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    deleteData(indexValue);
                    Navigator.of(context).pop();
                  },
                  child: const Text("YES")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "NO",
                  )),
            ],
          );
        });
  }
}
