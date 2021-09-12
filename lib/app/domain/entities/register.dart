import 'package:hive/hive.dart';
import 'registerable_class.dart';
part 'register.g.dart';

@HiveType(typeId: 30)
class Register extends HiveObject{
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registerableClass'] = this.registerableClass.toJson();
    data['points'] = this.points;
    data['total'] = this.total;
    data['student'] = this.student;
    return data;
  }
}
