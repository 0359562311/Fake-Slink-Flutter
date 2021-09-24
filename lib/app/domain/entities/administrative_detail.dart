import 'package:fakeslink/app/domain/entities/student.dart';

import 'lecturer.dart';

class AdministrativeClassDetails {
  Lecturer lecturer;
  String faculty;
  String administrativeClassId;
  List<Student> students;

  AdministrativeClassDetails(
      {required this.lecturer,
      required this.faculty,
      required this.administrativeClassId,
      required this.students});
}
