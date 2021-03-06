import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:hive/hive.dart';

import 'lecturer_model.dart';

part 'administrative_class_details_model.g.dart';

@HiveType(typeId: 31)
class AdministrativeClassDetailsModel extends AdministrativeClassDetails {
  AdministrativeClassDetailsModel(
      {lecturer,
      faculty,
      administrativeClassId,
      required List<Student> students})
      : super(
            lecturer: lecturer,
            faculty: faculty,
            administrativeClassId: administrativeClassId,
            students: students);

  factory AdministrativeClassDetailsModel.fromJson(Map<String, dynamic> json) {
    final _students = <Student>[];
    json['students'].forEach((v) {
      _students.add(new StudentModel.fromJson(v));
    });
    return AdministrativeClassDetailsModel(
        lecturer: LecturerModel.fromJson(json['lecturer']),
        faculty: json['faculty'],
        administrativeClassId: json['administrativeClassId'],
        students: _students);
  }
}
