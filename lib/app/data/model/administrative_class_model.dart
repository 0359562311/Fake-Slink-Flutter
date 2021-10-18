import 'package:fakeslink/app/domain/entities/administrative_class.dart';
import 'package:hive/hive.dart';
part 'administrative_class_model.g.dart';

@HiveType(typeId: 7)
class AdministrativeClassModel extends AdministrativeClass {
  AdministrativeClassModel({id, administrativeClassId, faculty, lecturer})
      : super(
            id: id,
            administrativeClassId: administrativeClassId,
            faculty: faculty,
            lecturer: lecturer);

  factory AdministrativeClassModel.fromJson(Map<String, dynamic> json) {
    return AdministrativeClassModel(
      id: json['id'],
      administrativeClassId: json['administrativeClassId'],
      faculty: json['faculty'],
      lecturer: json['lecturer'],
    );
  }
}
