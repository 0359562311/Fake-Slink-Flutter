import 'package:fakeslink/app/domain/entities/schedule.dart';

abstract class ScheduleRepository{
  Future<List<Schedule>> getListSchedule();
}