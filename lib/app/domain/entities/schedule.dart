import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:hive/hive.dart';
import 'lecturer.dart';

part 'schedule.g.dart';

@HiveType(typeId: 1)
class Schedule extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  Lecturer lecturer;
  @HiveField(2)
  RegisterableClass registerableClass;
  @HiveField(3)
  int dayOfWeek;
  @HiveField(4)
  String classroom;
  @HiveField(5)
  String startAt;
  @HiveField(6)
  String endAt;
  @HiveField(7)
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
}

