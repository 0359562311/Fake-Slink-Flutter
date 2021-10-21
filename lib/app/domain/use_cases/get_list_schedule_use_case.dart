import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class GetListScheduleUseCase {
  final ScheduleRepository repository;

  GetListScheduleUseCase(this.repository);

  Future<Result<Failure, List<Schedule>>> execute() =>
      repository.getListSchedule();
}
