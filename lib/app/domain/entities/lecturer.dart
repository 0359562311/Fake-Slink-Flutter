class Lecturer {
  String lecturerId;
  String educationLevel;
  int id;
  String name;
  String? dob;
  String? address;
  String? avatar;
  String? cover;
  String gender;
  String role;
  String? phoneNumber;
  String createAt;
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