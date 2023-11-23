import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trekzen/db_model/model.dart';

// ignore: non_constant_identifier_names
ValueNotifier<List<UserModel>> UserListNotifier = ValueNotifier([]);

Future<void> addUser(UserModel value) async {
  // ignore: non_constant_identifier_names
  final UserDB = await Hive.openBox<UserModel>('User_db');

  UserDB.put(value.id, value);
  getallUser();
}

Future<void> getallUser() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  UserListNotifier.value.clear();

  UserListNotifier.value.addAll(userDB.values);
  // studentListNotifier.value.add(studentDB.values);
  UserListNotifier.notifyListeners();
}

Future<void> deleteUser(int id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');

  await userDB.deleteAt(id);

  getallUser();
}

Future<void> deleteAllUsers() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await userDB.clear();
  getallUser();
}

Future<void> updateList(int id, UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userDB.putAt(id, value);
  getallUser();
}
