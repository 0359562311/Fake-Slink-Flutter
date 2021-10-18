import 'package:hive/hive.dart';

import 'package:fakeslink/app/domain/entities/subject.dart';

import 'lecturer.dart';
import 'student.dart';

abstract class RegisterableClass extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  Subject subject;
  @HiveField(2)
  String semester;
  List<Student> get students;
  List<Lecturer> get lecturers;

  RegisterableClass({
    required this.id,
    required this.subject,
    required this.semester,
  });
}
