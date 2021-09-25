import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';

abstract class ScheduleRepository{
  const ScheduleRepository();
  Future<Pair<String,List<Schedule>>> getListSchedule();
}