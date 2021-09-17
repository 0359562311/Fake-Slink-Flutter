import 'package:fakeslink/app/domain/entities/schedule.dart';

class ScheduleItem {
  final Schedule schedule;
  final int start;
  final int end;
  final String startAt;
  final String endAt;
  final DateTime date;
  final String classroom;
  final String subjectName;

  const ScheduleItem(this.schedule, this.start, this.end, this.startAt, this.endAt, this.date,
      this.classroom, this.subjectName);
}