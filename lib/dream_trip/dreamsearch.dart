import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trekzen/db_model/dream_database/drm_db.dart';
import 'package:trekzen/db_model/model.dart';
import 'package:trekzen/dream_trip/dreamdisplay.dart';
import 'package:trekzen/dream_trip/dreamprofile.dart';

class DreamSearch extends SearchDelegate {
  // first override to clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          Navigator.of(context).pop();
          // query = ''
        },
      ),
    ];
  }

  //to pop out of the search menu
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // for closing the search page and going back
      },
    );
  }

//to show query result
  @override
  Widget buildResults(BuildContext context) {
    //bool output = true;
    return ValueListenableBuilder(
      valueListenable: dreamListNotifier,
      builder:
          ((BuildContext context, List<DreamModel> dreamList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = dreamList[index];
            String nameVal = data.nametwo;
            if ((nameVal).contains((query.trim()))) {
              print('matched!!!!');
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return const DreamDisplay();
                          }),
                        ),
                      );
                    },
                    title: Text("${data.nametwo} "),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.photo)),
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              print('no result');
              //output = false;
            }
            return null;
          },
          itemCount: dreamList.length,
        );
      }),
    );
  }

  //to show the querying process ie suggestions at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dreamListNotifier,
      builder:
          ((BuildContext context, List<DreamModel> dreamList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = dreamList[index];
            String nameVal = data.nametwo;
            if ((nameVal).contains((query))) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return DreamProfile(
                                name: data.name,
                                nametwo: data.nametwo,
                                phone: data.phone,
                                address: data.adress,
                                start: data.start,
                                end: data.end,
                                amount: data.amount,
                                expense: data.expense,
                                dropdown: data.dropdown,
                                index: index,
                                photo: data.photo);
                          }),
                        ),
                      );
                    },
                    title: Text("${data.nametwo}"),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.photo)),
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: dreamList.length,
        );
      }),
    );
  }
}
