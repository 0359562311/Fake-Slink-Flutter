import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:hive/hive.dart';

import 'administrative_class_model.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends Student {
  @HiveField(1)
  @override
  final AdministrativeClassModel administrativeClass;
  StudentModel(
      {studentId,
      required this.administrativeClass,
      id,
      name,
      dob,
      address,
      avatar,
      cover,
      gender,
      role,
      phoneNumber,
      createAt,
      gpa,
      email,
      updateAt})
      : super(
            studentId: studentId,
            id: id,
            name: name,
            dob: dob,
            address: address,
            avatar: avatar,
            cover: cover,
            gender: gender,
            role: role,
            phoneNumber: phoneNumber,
            createAt: createAt,
            updateAt: updateAt,
            email: email,
            gpa: gpa);

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        studentId: json['studentId'],
        administrativeClass:
            AdministrativeClassModel.fromJson(json['administrativeClass']),
        id: json['id'],
        name: json['name'],
        dob: json['dob'],
        address: json['address'],
        avatar: json['avatar'],
        cover: json['cover'],
        gender: json['gender'],
        role: json['role'],
        phoneNumber: json['phoneNumber'],
        createAt: json['createAt'],
        updateAt: json['updateAt'],
        email: json['email'],
        gpa: json['gpa']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['cover'] = this.cover;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
