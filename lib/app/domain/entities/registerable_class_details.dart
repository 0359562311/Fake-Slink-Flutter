import 'package:fakeslink/app/domain/entities/student.dart';

import 'lecturer.dart';
import 'subject.dart';

class RegisterableClassDetails {
  int id;
  List<Student> students;
  List<Lecturer> lecturers;
  Subject subject;
  String semester;

  RegisterableClassDetails(
      {required this.id, required this.students, required this.lecturers, required this.subject, required this.semester});
}