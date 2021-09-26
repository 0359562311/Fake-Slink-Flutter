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
      students: (fields[3] as List).cast<Student>(),
      lecturers: (fields[4] as List).cast<Lecturer>(),
    );
  }

  @override
  void write(BinaryWriter writer, RegisterableClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.semester)
      ..writeByte(3)
      ..write(obj.students)
      ..writeByte(4)
      ..write(obj.lecturers);
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
