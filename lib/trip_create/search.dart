import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trekzen/db_model/database/db.dart';
import 'package:trekzen/db_model/model.dart';
import 'package:trekzen/trip_create/list.dart';
import 'package:trekzen/trip_create/profile.dart';

class ScreenSearch extends SearchDelegate {
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

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UserListNotifier,
      builder:
          ((BuildContext context, List<UserModel> userList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = userList[index];
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
                            return const ListDataWidget();
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
          itemCount: userList.length,
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UserListNotifier,
      builder:
          ((BuildContext context, List<UserModel> userList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = userList[index];
            String nameVal = data.nametwo;
            if ((nameVal).contains((query))) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return ScreenProfile(
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
                    title: Text(data.nametwo),
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
          itemCount: userList.length,
        );
      }),
    );
  }
}
