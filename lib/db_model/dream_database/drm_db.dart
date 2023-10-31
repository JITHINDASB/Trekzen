import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trekzen/db_model/model.dart';

ValueNotifier<List<DreamModel>> dreamListNotifier = ValueNotifier([]);

Future<void> addDream(DreamModel value) async {
  final dreamDB = await Hive.openBox<DreamModel>('dream_db');

  dreamDB.put(value.id, value);
  getalldata();
}

Future<void> getalldata() async {
  final dreamDB = await Hive.openBox<DreamModel>('dream_db');
  dreamListNotifier.value.clear();

  dreamListNotifier.value.addAll(dreamDB.values);

  // studentListNotifier.value.add(studentDB.values);
  dreamListNotifier.notifyListeners();
}

Future<void> deleteData(int id) async {
  final dreamDB = await Hive.openBox<DreamModel>('dream_db');

  await dreamDB.deleteAt(id);

  getalldata();
}

Future<void> deleteAllDatas() async {
  final dreamDB = await Hive.openBox<DreamModel>('dream_db');
  await dreamDB.clear();
  getalldata();
}

Future<void> updateTrip(int id, DreamModel value) async {
  final userDB = await Hive.openBox<DreamModel>('dream_db');
  userDB.putAt(id, value);
  getalldata();
}
