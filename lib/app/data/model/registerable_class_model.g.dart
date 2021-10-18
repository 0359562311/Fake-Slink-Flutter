// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registerable_class_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterableClassModelAdapter
    extends TypeAdapter<RegisterableClassModel> {
  @override
  final int typeId = 2;

  @override
  RegisterableClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterableClassModel(
      id: fields[0] as dynamic,
      subject: fields[1] as dynamic,
      semester: fields[2] as dynamic,
      students: (fields[4] as List).cast<StudentModel>(),
      lecturers: (fields[3] as List).cast<LecturerModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RegisterableClassModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(3)
      ..write(obj.lecturers)
      ..writeByte(4)
      ..write(obj.students)
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
      other is RegisterableClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
