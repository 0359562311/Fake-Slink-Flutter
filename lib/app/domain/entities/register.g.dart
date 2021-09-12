// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterAdapter extends TypeAdapter<Register> {
  @override
  final int typeId = 30;

  @override
  Register read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Register(
      id: fields[0] as int,
      registerableClass: fields[1] as RegisterableClass,
      points: (fields[2] as List?)?.cast<double>(),
      total: fields[3] as double?,
      student: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Register obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.registerableClass)
      ..writeByte(2)
      ..write(obj.points)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.student);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
