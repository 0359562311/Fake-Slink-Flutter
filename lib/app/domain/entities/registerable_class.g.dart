// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registerable_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterableClassAdapter extends TypeAdapter<RegisterableClass> {
  @override
  final int typeId = 2;

  @override
  RegisterableClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterableClass(
      id: fields[0] as int,
      subject: fields[1] as Subject,
      semester: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterableClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.semester);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterableClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
