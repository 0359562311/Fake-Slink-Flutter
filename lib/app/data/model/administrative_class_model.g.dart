// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrative_class_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdministrativeClassModelAdapter
    extends TypeAdapter<AdministrativeClassModel> {
  @override
  final int typeId = 7;

  @override
  AdministrativeClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdministrativeClassModel(
      id: fields[0] as dynamic,
      administrativeClassId: fields[1] as dynamic,
      faculty: fields[4] as dynamic,
      lecturer: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AdministrativeClassModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.administrativeClassId)
      ..writeByte(4)
      ..write(obj.faculty)
      ..writeByte(3)
      ..write(obj.lecturer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdministrativeClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
