import 'dart:convert';

import 'package:intl/intl.dart';

final DateFormat _dateFormat = new DateFormat("dd-MM-yyyy");
class Notification {
  final int id;
  final NotificationDetails details;
  bool seen;
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

class NotificationDetails {
  int id;
  Sender sender;
  String title;
  String details;
  String createAt;
  String type;

  NotificationDetails(
      this.id, this.sender, this.title, this.details, this.createAt, this.type);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender.toMap(),
      'title': title,
      'details': details,
      'createAt': _dateFormat.format(DateTime.parse(createAt)),
      'type': type,
    };
  }

  factory NotificationDetails.fromJson(Map<String, dynamic> map) {
    return NotificationDetails(
      map['id'],
      Sender.fromJson(map['sender']),
      map['title'],
      map['details'],
      _dateFormat.format(DateTime.parse(map['createAt'])),
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
