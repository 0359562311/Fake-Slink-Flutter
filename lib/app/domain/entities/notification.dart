import 'dart:convert';

class Notification {
  final int id;
  final Details details;
  final bool seen;
  final int receiver;

  Notification(
      {required this.id,
      required this.details,
      required this.seen,
      required this.receiver});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details.toJson();
    data['seen'] = this.seen;
    data['receiver'] = this.receiver;
    return data;
  }
}

class Details {
  int id;
  Sender sender;
  String title;
  String details;
  String createAt;
  String type;

  Details(
      this.id, this.sender, this.title, this.details, this.createAt, this.type);

  // Details.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   sender =
  //   json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  //   title = json['title'];
  //   details = json['details'];
  //   createAt = json['createAt'];
  //   type = json['type'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   if (this.sender != null) {
  //     data['sender'] = this.sender.toJson();
  //   }
  //   data['title'] = this.title;
  //   data['details'] = this.details;
  //   data['createAt'] = this.createAt;
  //   data['type'] = this.type;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender.toMap(),
      'title': title,
      'details': details,
      'createAt': createAt,
      'type': type,
    };
  }

  factory Details.fromJson(Map<String, dynamic> map) {
    return Details(
      map['id'],
      Sender.fromJson(map['sender']),
      map['title'],
      map['details'],
      map['createAt'],
      map['type'],
    );
  }

  String toJson() => json.encode(toMap());
}

class Sender {
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

  Sender(this.id, this.name, this.dob, this.address, this.avatar, this.cover,
      this.gender, this.role, this.phoneNumber, this.createAt, this.updateAt);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dob': dob,
      'address': address,
      'avatar': avatar,
      'cover': cover,
      'gender': gender,
      'role': role,
      'phoneNumber': phoneNumber,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  factory Sender.fromJson(Map<String, dynamic> map) {
    return Sender(
      map['id'],
      map['name'],
      map['dob'],
      (map['address']),
      (map['avatar']),
      (map['cover']),
      map['gender'],
      map['role'],
      (map['phoneNumber']),
      map['createAt'],
      map['updateAt'],
    );
  }

  String toJson() => json.encode(toMap());
}
