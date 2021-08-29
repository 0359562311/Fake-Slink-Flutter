import 'package:fakeslink/app/data/model/subject_model.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';

class RegisterableClassModel extends RegisterableClass {
  RegisterableClassModel({required id, required subject, required semester})
      : super(id: id, semester: semester, subject: subject);

  factory RegisterableClassModel.fromJson(Map<String, dynamic> json) {
    return RegisterableClassModel(
        id: json['id'],
        subject: SubjectModel.fromJson(json['subject']),
        semester: json['semester']);
  }
}
