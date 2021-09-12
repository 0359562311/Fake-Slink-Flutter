import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/schedule_sources.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';
import 'package:fakeslink/core/utils/network_info.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleRemoteSource _remoteSource;
  final ScheduleLocalSource _localSource;

  const ScheduleRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<List<Schedule>> getListSchedule() async {
    if (NetworkInfo.isConnecting) {
      try {
        final schedules = await _remoteSource.getListSchedule();
        _localSource.cacheSchedules(schedules);
        return schedules;
      } on DioError {
        return _localSource.getListSchedule();
      }
    } else {
      return _localSource.getListSchedule();
    }
  }
}