import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/domain/entities/administrative_detail.dart';
import 'package:fakeslink/app/domain/entities/student.dart';

import 'lecturer_model.dart';

class AdministrativeClassDetailsModel extends AdministrativeClassDetails {
  AdministrativeClassDetailsModel({lecturer, faculty, administrativeClassId, students}) : super(
    lecturer: lecturer,
    faculty: faculty,
    administrativeClassId: administrativeClassId,
    students: students
  );

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