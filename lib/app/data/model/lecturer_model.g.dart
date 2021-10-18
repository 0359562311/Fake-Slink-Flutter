// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecturer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LecturerModelAdapter extends TypeAdapter<LecturerModel> {
  @override
  final int typeId = 20;

  @override
  LecturerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LecturerModel(
      lecturerId: fields[0] as dynamic,
      educationLevel: fields[1] as dynamic,
      id: fields[2] as dynamic,
      name: fields[3] as dynamic,
      dob: fields[4] as dynamic,
      address: fields[5] as dynamic,
      avatar: fields[6] as dynamic,
      cover: fields[7] as dynamic,
      gender: fields[8] as dynamic,
      role: fields[9] as dynamic,
      phoneNumber: fields[10] as dynamic,
      createAt: fields[11] as dynamic,
      updateAt: fields[12] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, LecturerModel obj) {
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
      other is LecturerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
