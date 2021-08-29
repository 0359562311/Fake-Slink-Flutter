import 'package:fakeslink/app/data/sources/schedule_sources.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleRemoteSource remoteSource;

  ScheduleRepositoryImpl(this.remoteSource);

  @override
  Future<List<Schedule>> getListSchedule() {
    return remoteSource.getListSchedule();
  }
}