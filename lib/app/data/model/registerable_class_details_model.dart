import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/domain/entities/lecturer.dart';
import 'package:fakeslink/app/domain/entities/registerable_class_details.dart';
import 'package:fakeslink/app/domain/entities/student.dart';

import 'lecturer_model.dart';
import 'subject_model.dart';

class RegisterableClassDetailsModel extends RegisterableClassDetails {
  RegisterableClassDetailsModel({id, students, lecturers, subject, semester})
      : super(
            id: id,
            students: students,
            lecturers: lecturers,
            subject: subject,
            semester: semester);

  factory RegisterableClassDetailsModel.fromJson(Map<String, dynamic> json) {
    final students = <Student>[];
    json['students'].forEach((v) {
      students.add(new StudentModel.fromJson(v));
    });
    final lecturers = <Lecturer>[];
    json['lecturers'].forEach((v) {
      lecturers.add(new LecturerModel.fromJson(v));
    });
    return RegisterableClassDetailsModel(
      id: json['id'],
      students: students,
      lecturers: lecturers,
      subject: SubjectModel.fromJson(json['subject']),
      semester: json['semester'],
    );
  }
}
