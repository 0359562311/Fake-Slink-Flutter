import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';

class GetListScheduleUseCase{
  final ScheduleRepository repository;

  GetListScheduleUseCase(this.repository);

  Future<Pair<String,List<Schedule>>> execute() => repository.getListSchedule();
}