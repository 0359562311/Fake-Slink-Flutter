import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/data/model/subject_model.dart';
import 'package:fakeslink/app/domain/entities/lecturer.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/app/domain/entities/student.dart';

import 'lecturer_model.dart';

class RegisterableClassModel extends RegisterableClass {
  RegisterableClassModel({required id, required subject, required semester, students, lecturers})
      : super(id: id, semester: semester, subject: subject, students: students, lecturers: lecturers);

  factory RegisterableClassModel.fromJson(Map<String, dynamic> json) {
    final _students = <Student>[];
    json['students']?.forEach((v) {
      _students.add(new StudentModel.fromJson(v));
    });
    final _lecturers = <Lecturer>[];
    json['lecturers']?.forEach((v) {
      _lecturers.add(new LecturerModel.fromJson(v));
    });
    return RegisterableClassModel(
        id: json['id'],
        subject: SubjectModel.fromJson(json['subject']),
        semester: json['semester'],
        students: _students,
        lecturers: _lecturers
        );
  }
}
