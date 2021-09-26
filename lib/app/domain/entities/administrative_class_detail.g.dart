// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrative_class_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdministrativeClassDetailsAdapter
    extends TypeAdapter<AdministrativeClassDetails> {
  @override
  final int typeId = 31;

  @override
  AdministrativeClassDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdministrativeClassDetails(
      lecturer: fields[0] as Lecturer,
      faculty: fields[1] as String,
      administrativeClassId: fields[2] as String,
      students: (fields[3] as List).cast<Student>(),
    );
  }

  @override
  void write(BinaryWriter writer, AdministrativeClassDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.lecturer)
      ..writeByte(1)
      ..write(obj.faculty)
      ..writeByte(2)
      ..write(obj.administrativeClassId)
      ..writeByte(3)
      ..write(obj.students);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdministrativeClassDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
