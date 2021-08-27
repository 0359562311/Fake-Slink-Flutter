class CustomUser {
  String studentId;
  AdministrativeClass administrativeClass;
  int id;
  String name;
  String dob;
  String? address;
  String? avatar;
  String? cover;
  String gender;
  String role;
  String? phoneNumber;
  String createAt;
  String updateAt;

  CustomUser( 
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
      required this.updateAt});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    if (this.administrativeClass != null) {
      data['administrativeClass'] = this.administrativeClass.toJson();
    }
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

class AdministrativeClass {
  int id;
  String administrativeClassId;
  String profession;
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
