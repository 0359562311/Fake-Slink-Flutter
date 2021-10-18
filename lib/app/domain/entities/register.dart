import 'package:hive/hive.dart';
import 'registerable_class.dart';

class Register extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  RegisterableClass registerableClass;
  @HiveField(2)
  List<double>? points;
  @HiveField(3)
  double? total;
  @HiveField(4)
  int student;

  Register(
      {required this.id,
      required this.registerableClass,
      required this.points,
      required this.total,
      required this.student});
}
