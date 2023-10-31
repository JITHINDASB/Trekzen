// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      name: fields[1] as String,
      nametwo: fields[2] as String,
      phone: fields[3] as String,
      adress: fields[4] as String,
      start: fields[5] as String,
      end: fields[6] as String,
      amount: fields[7] as String,
      expense: fields[8] as String,
      dropdown: fields[9] as String,
      photo: fields[10] as String,
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nametwo)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.adress)
      ..writeByte(5)
      ..write(obj.start)
      ..writeByte(6)
      ..write(obj.end)
      ..writeByte(7)
      ..write(obj.amount)
      ..writeByte(8)
      ..write(obj.expense)
      ..writeByte(9)
      ..write(obj.dropdown)
      ..writeByte(10)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DreamModelAdapter extends TypeAdapter<DreamModel> {
  @override
  final int typeId = 2;

  @override
  DreamModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DreamModel(
      name: fields[1] as String,
      nametwo: fields[2] as String,
      phone: fields[3] as String,
      adress: fields[4] as String,
      start: fields[5] as String,
      end: fields[6] as String,
      amount: fields[7] as String,
      expense: fields[8] as String,
      dropdown: fields[9] as String,
      photo: fields[10] as String,
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DreamModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nametwo)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.adress)
      ..writeByte(5)
      ..write(obj.start)
      ..writeByte(6)
      ..write(obj.end)
      ..writeByte(7)
      ..write(obj.amount)
      ..writeByte(8)
      ..write(obj.expense)
      ..writeByte(9)
      ..write(obj.dropdown)
      ..writeByte(10)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DreamModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
