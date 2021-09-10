import 'package:fakeslink/app/domain/entities/schedule.dart';

abstract class ScheduleRepository{
  const ScheduleRepository();
  Future<List<Schedule>> getListSchedule();
}