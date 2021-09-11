
import 'package:hive/hive.dart';
part 'student.g.dart';
@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  String studentId;
  @HiveField(1)
  AdministrativeClass administrativeClass;
  @HiveField(2)
  int id;
  @HiveField(3)
  String name;
  @HiveField(4)
  String dob;
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
  @HiveField(13)
  double gpa;


  Student( 
      {
        required this.studentId,
      required this.administrativeClass,
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
      required this.gpa,
      required this.updateAt});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['administrativeClass'] = this.administrativeClass.toJson();
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
    data['gpa'] = this.gpa;
    return data;
  }
}

@HiveType(typeId: 10)
class AdministrativeClass extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String administrativeClassId;
  @HiveField(2)
  String profession;
  @HiveField(3)
  int lecturer;

  AdministrativeClass(
      {required this.id, required this.administrativeClassId, required this.profession, required this.lecturer});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['administrativeClassId'] = this.administrativeClassId;
    data['profession'] = this.profession;
    data['lecturer'] = this.lecturer;
    return data;
  }
}
