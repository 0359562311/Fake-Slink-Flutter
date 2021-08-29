import 'package:fakeslink/app/domain/entities/subject.dart';

class RegisterableClass {
  int id;
  Subject subject;
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