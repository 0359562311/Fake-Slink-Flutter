import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ScheduleRepository {
  const ScheduleRepository();
  Future<Result<Failure, List<Schedule>>> getListSchedule();
}
