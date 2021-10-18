import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/schedule_sources.dart';
import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleRemoteSource _remoteSource;
  final ScheduleLocalSource _localSource;

  const ScheduleRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Pair<String, List<Schedule>>> getListSchedule() async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final schedules = await _remoteSource.getListSchedule();
        _localSource.cacheSchedules(schedules);
        return Pair(result: schedules);
      } on DioError catch (e) {
        return Pair(
            result: await _localSource.getListSchedule(),
            error: e.response?.data['detail'] ?? "Đã có lỗi xảy ra");
      }
    } else {
      return Pair(result: await _localSource.getListSchedule());
    }
  }
}
