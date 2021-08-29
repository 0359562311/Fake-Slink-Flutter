import 'package:fakeslink/app/domain/entities/registerable_class.dart';

import 'lecturer.dart';

class Schedule {
  int id;
  Lecturer lecturer;
  RegisterableClass registerableClass;
  int dayOfWeek;
  String classroom;
  String startAt;
  String endAt;
  List<int> weeks;

  Schedule(
      {required this.id,
        required this.lecturer,
        required this.registerableClass,
        required this.dayOfWeek,
        required this.classroom,
        required this.startAt,
        required this.endAt,
        required this.weeks});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lecturer'] = this.lecturer.toJson();
    data['registerableClass'] = this.registerableClass.toJson();
    data['dayOfWeek'] = this.dayOfWeek;
    data['classroom'] = this.classroom;
    data['startAt'] = this.startAt;
    data['endAt'] = this.endAt;
    data['weeks'] = this.weeks;
    return data;
  }
}

