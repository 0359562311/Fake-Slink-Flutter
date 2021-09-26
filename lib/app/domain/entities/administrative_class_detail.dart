import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:hive/hive.dart';

import 'lecturer.dart';
part 'administrative_class_detail.g.dart';

@HiveType(typeId: 31)
class AdministrativeClassDetails extends HiveObject {
  @HiveField(0)
  Lecturer lecturer;
  @HiveField(1)
  String faculty;
  @HiveField(2)
  String administrativeClassId;
  @HiveField(3)
  List<Student> students;

  AdministrativeClassDetails(
      {required this.lecturer,
      required this.faculty,
      required this.administrativeClassId,
      required this.students});
}
