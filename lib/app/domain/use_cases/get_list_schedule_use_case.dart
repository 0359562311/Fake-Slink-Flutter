import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';

class GetListScheduleUseCase{
  final ScheduleRepository repository;

  GetListScheduleUseCase(this.repository);

  Future<List<Schedule>> execute() => repository.getListSchedule();
}