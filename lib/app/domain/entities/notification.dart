import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'notification.g.dart';

final DateFormat _dateFormat = new DateFormat("dd-MM-yyyy");

@HiveType(typeId: 4)
class Notification {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final NotificationDetails details;
  @HiveField(2)
  bool seen;
  @HiveField(3)
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

@HiveType(typeId: 5)
class NotificationDetails extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  Sender sender;
  @HiveField(2)
  String title;
  @HiveField(3)
  String details;
  @HiveField(4)
  String createAt;
  @HiveField(5)
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

@HiveType(typeId: 6)
class Sender extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String dob;
  @HiveField(3)
  String? address;
  @HiveField(4)
  String? avatar;
  @HiveField(5)
  String? cover;
  @HiveField(6)
  String gender;
  @HiveField(7)
  String role;
  @HiveField(8)
  String? phoneNumber;
  @HiveField(9)
  String createAt;
  @HiveField(10)
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
