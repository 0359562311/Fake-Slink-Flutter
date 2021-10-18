import 'package:fakeslink/app/domain/entities/lecturer.dart';
import 'package:hive/hive.dart';

part 'lecturer_model.g.dart';

@HiveType(typeId: 20)
class LecturerModel extends Lecturer {
  LecturerModel(
      {required lecturerId,
      required educationLevel,
      required id,
      required name,
      required dob,
      required address,
      required avatar,
      required cover,
      required gender,
      required role,
      required phoneNumber,
      required createAt,
      required updateAt})
      : super(
            id: id,
            name: name,
            createAt: createAt,
            dob: dob,
            educationLevel: educationLevel,
            gender: gender,
            lecturerId: lecturerId,
            role: role,
            updateAt: updateAt,
            address: address,
            avatar: avatar,
            cover: cover,
            phoneNumber: phoneNumber);

  factory LecturerModel.fromJson(Map<String, dynamic> json) {
    return LecturerModel(
      lecturerId: json['lecturerId'],
      educationLevel: json['education_level'],
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
    );
  }
}
