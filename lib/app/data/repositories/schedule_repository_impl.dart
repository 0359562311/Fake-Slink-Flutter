import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/schedule_sources.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleRemoteSource remoteSource;
  final ScheduleLocalSource localSource;

  const ScheduleRepositoryImpl(this.remoteSource, this.localSource);

  @override
  Future<List<Schedule>> getListSchedule() async {
    try {
      final schedules = await remoteSource.getListSchedule();
      localSource.cacheSchedules(schedules);
      return schedules;
    } on DioError catch (e) {
      return localSource.getListSchedule();
    }
  }
}