import 'package:hive/hive.dart';

class Lecturer extends HiveObject {
  @HiveField(0)
  String lecturerId;
  @HiveField(1)
  String educationLevel;
  @HiveField(2)
  int id;
  @HiveField(3)
  String name;
  @HiveField(4)
  String? dob;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? avatar;
  @HiveField(7)
  String? cover;
  @HiveField(8)
  String gender;
  @HiveField(9)
  String role;
  @HiveField(10)
  String? phoneNumber;
  @HiveField(11)
  String createAt;
  @HiveField(12)
  String updateAt;

  Lecturer(
      {required this.lecturerId,
      required this.educationLevel,
      required this.id,
      required this.name,
      required this.dob,
      this.address,
      this.avatar,
      this.cover,
      required this.gender,
      required this.role,
      this.phoneNumber,
      required this.createAt,
      required this.updateAt});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lecturerId'] = this.lecturerId;
    data['education_level'] = this.educationLevel;
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['cover'] = this.cover;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['phoneNumber'] = this.phoneNumber;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
