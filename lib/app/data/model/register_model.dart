import 'package:fakeslink/app/data/model/registerable_class_model.dart';
import 'package:fakeslink/app/domain/entities/register.dart';

class RegisterModel extends Register {
  RegisterModel(
      {required registerableClass,
      required id,
      required points,
      required total,
      required student})
      : super(
    id: id,
    registerableClass: registerableClass,
    points: points,
    total: total,
    student: student
  );

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        id: json['id'],
        registerableClass:
            RegisterableClassModel.fromJson(json['registerableClass']),
        points: json['points'].cast<double>(),
        total: json['total'],
        student: json['student'],
      );
}
