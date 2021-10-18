import 'package:hive/hive.dart';

import 'administrative_class.dart';

abstract class Student extends HiveObject {
  @HiveField(0)
  String studentId;
  AdministrativeClass get administrativeClass;
  @HiveField(2)
  int id;
  @HiveField(3)
  String name;
  @HiveField(4)
  String dob;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? avatar;
  @HiveField(7)
  String? cover;
  @HiveField(8)
  String gender;
  @HiveField(9)
  String role;
  @HiveField(10)
  String? phoneNumber;
  @HiveField(11)
  String createAt;
  @HiveField(12)
  String updateAt;
  @HiveField(13)
  double gpa;

  Student(
      {required this.studentId,
      required this.id,
      required this.name,
      required this.dob,
      this.address,
      this.avatar,
      this.cover,
      required this.gender,
      required this.role,
      this.phoneNumber,
      required this.createAt,
      required this.gpa,
      required this.updateAt,
      administrativeClass});
}
