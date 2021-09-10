// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecturer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LecturerAdapter extends TypeAdapter<Lecturer> {
  @override
  final int typeId = 20;

  @override
  Lecturer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lecturer(
      lecturerId: fields[0] as String,
      educationLevel: fields[1] as String,
      id: fields[2] as int,
      name: fields[3] as String,
      dob: fields[4] as String?,
      address: fields[5] as String?,
      avatar: fields[6] as String?,
      cover: fields[7] as String?,
      gender: fields[8] as String,
      role: fields[9] as String,
      phoneNumber: fields[10] as String?,
      createAt: fields[11] as String,
      updateAt: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Lecturer obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.lecturerId)
      ..writeByte(1)
      ..write(obj.educationLevel)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.dob)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.avatar)
      ..writeByte(7)
      ..write(obj.cover)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.role)
      ..writeByte(10)
      ..write(obj.phoneNumber)
      ..writeByte(11)
      ..write(obj.createAt)
      ..writeByte(12)
      ..write(obj.updateAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LecturerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
