import 'package:hive/hive.dart';

class AdministrativeClass extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String administrativeClassId;
  @HiveField(4)
  String faculty;
  @HiveField(3)
  int lecturer;

  AdministrativeClass(
      {required this.id,
      required this.administrativeClassId,
      required this.faculty,
      required this.lecturer});
}
