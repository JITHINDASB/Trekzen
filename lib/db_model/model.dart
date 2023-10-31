import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String nametwo;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String adress;

  @HiveField(5)
  final String start;

  @HiveField(6)
  final String end;

  @HiveField(7)
  final String amount;

  @HiveField(8)
  final String expense;

  @HiveField(9)
  final String dropdown;

  @HiveField(10)
  final String photo;

  UserModel({
    required this.name,
    required this.nametwo,
    required this.phone,
    required this.adress,
    required this.start,
    required this.end,
    required this.amount,
    required this.expense,
    required this.dropdown,
    required this.photo,
    required this.id,
  });
}

@HiveType(typeId: 2)
class DreamModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String nametwo;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String adress;

  @HiveField(5)
  final String start;

  @HiveField(6)
  final String end;

  @HiveField(7)
  final String amount;

  @HiveField(8)
  final String expense;

  @HiveField(9)
  final String dropdown;

  @HiveField(10)
  final String photo;

  DreamModel({
    required this.name,
    required this.nametwo,
    required this.phone,
    required this.adress,
    required this.start,
    required this.end,
    required this.amount,
    required this.expense,
    required this.dropdown,
    required this.photo,
    required this.id,
  });
}
