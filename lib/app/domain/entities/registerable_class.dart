import 'package:fakeslink/app/domain/entities/subject.dart';
import 'package:hive/hive.dart';
part 'registerable_class.g.dart';

@HiveType(typeId: 2)
class RegisterableClass extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  Subject subject;
  @HiveField(2)
  String semester;

  RegisterableClass({required this.id, required this.subject, required this.semester});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject.toJson();
    data['semester'] = this.semester;
    return data;
  }
}