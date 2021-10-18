import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/data/model/subject_model.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:hive/hive.dart';

import 'lecturer_model.dart';

part 'registerable_class_model.g.dart';

@HiveType(typeId: 2)
class RegisterableClassModel extends RegisterableClass {
  RegisterableClassModel(
      {required id,
      required subject,
      required semester,
      required this.students,
      required this.lecturers})
      : super(id: id, semester: semester, subject: subject);

  factory RegisterableClassModel.fromJson(Map<String, dynamic> json) {
    final _students = <StudentModel>[];
    json['students']?.forEach((v) {
      _students.add(new StudentModel.fromJson(v));
    });
    final _lecturers = <LecturerModel>[];
    json['lecturers']?.forEach((v) {
      _lecturers.add(new LecturerModel.fromJson(v));
    });
    return RegisterableClassModel(
        id: json['id'],
        subject: SubjectModel.fromJson(json['subject']),
        semester: json['semester'],
        students: _students,
        lecturers: _lecturers);
  }

  @HiveField(3)
  @override
  final List<LecturerModel> lecturers;

  @HiveField(4)
  @override
  final List<StudentModel> students;
}
