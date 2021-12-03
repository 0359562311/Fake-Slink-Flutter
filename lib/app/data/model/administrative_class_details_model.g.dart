// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrative_class_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdministrativeClassDetailsModelAdapter
    extends TypeAdapter<AdministrativeClassDetailsModel> {
  @override
  final int typeId = 31;

  @override
  AdministrativeClassDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdministrativeClassDetailsModel(
      lecturer: fields[0] as dynamic,
      faculty: fields[1] as dynamic,
      administrativeClassId: fields[2] as dynamic,
      students: (fields[3] as List).cast<Student>(),
    );
  }

  @override
  void write(BinaryWriter writer, AdministrativeClassDetailsModel obj) {
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
      other is AdministrativeClassDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
