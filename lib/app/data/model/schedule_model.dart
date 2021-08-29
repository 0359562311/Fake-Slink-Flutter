import 'package:fakeslink/app/data/model/lecturer_model.dart';
import 'package:fakeslink/app/data/model/registerable_class_model.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  ScheduleModel(
      {required id,
        required lecturer,
        required registerableClass,
        required dayOfWeek,
        required classroom,
        required startAt,
        required endAt,
        required weeks})
      : super(
    id: id,
    dayOfWeek: dayOfWeek,
    endAt: endAt,
    startAt: startAt,
    classroom: classroom,
    weeks: weeks,
    lecturer: lecturer,
    registerableClass: registerableClass
  );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json['id'],
        lecturer: LecturerModel.fromJson(json['lecturer']),
        registerableClass:
            RegisterableClassModel.fromJson(json['registerableClass']),
        dayOfWeek: json['dayOfWeek'],
        classroom: json['classroom'],
        startAt: json['startAt'],
        endAt: json['endAt'],
        weeks: json['weeks'].cast<int>(),
      );
}
