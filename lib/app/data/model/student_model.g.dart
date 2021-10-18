// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 0;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      studentId: fields[0] as dynamic,
      administrativeClass: fields[1] as AdministrativeClassModel,
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
      gpa: fields[13] as dynamic,
      updateAt: fields[12] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(1)
      ..write(obj.administrativeClass)
      ..writeByte(0)
      ..write(obj.studentId)
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
      ..write(obj.updateAt)
      ..writeByte(13)
      ..write(obj.gpa);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
