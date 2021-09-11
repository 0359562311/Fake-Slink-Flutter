import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 100)
class StudentModel extends Student {
  StudentModel(
      {studentId,
      required AdministrativeClass administrativeClass,
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
      updateAt})
      : super(
        studentId: studentId,
        id: id,
        administrativeClass: administrativeClass,
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
        gpa: gpa
      );

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
      gpa: json['gpa']
    );
  }
}

class AdministrativeClassModel extends AdministrativeClass {
  AdministrativeClassModel({id, administrativeClassId, profession, lecturer})
      : super(
            id: id,
            administrativeClassId: administrativeClassId,
            profession: profession,
            lecturer: lecturer);

  factory AdministrativeClassModel.fromJson(Map<String, dynamic> json) {
    return AdministrativeClassModel(
      id: json['id'],
      administrativeClassId: json['administrativeClassId'],
      profession: json['profession'],
      lecturer: json['lecturer'],
    );
  }
}
