// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      studentId: fields[0] as String,
      administrativeClass: fields[1] as AdministrativeClass,
      id: fields[2] as int,
      name: fields[3] as String,
      dob: fields[4] as String,
      address: fields[5] as String?,
      avatar: fields[6] as String?,
      cover: fields[7] as String?,
      gender: fields[8] as String,
      role: fields[9] as String,
      phoneNumber: fields[10] as String?,
      createAt: fields[11] as String,
      gpa: fields[13] as double,
      updateAt: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.studentId)
      ..writeByte(1)
      ..write(obj.administrativeClass)
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
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AdministrativeClassAdapter extends TypeAdapter<AdministrativeClass> {
  @override
  final int typeId = 10;

  @override
  AdministrativeClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdministrativeClass(
      id: fields[0] as int,
      administrativeClassId: fields[1] as String,
      profession: fields[2] as String,
      lecturer: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AdministrativeClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.administrativeClassId)
      ..writeByte(2)
      ..write(obj.profession)
      ..writeByte(3)
      ..write(obj.lecturer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdministrativeClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
