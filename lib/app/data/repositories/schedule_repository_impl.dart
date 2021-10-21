import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/schedule_sources.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleRemoteSource _remoteSource;
  final ScheduleLocalSource _localSource;

  const ScheduleRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Result<Failure, List<Schedule>>> getListSchedule() async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final schedules = await _remoteSource.getListSchedule();
        _localSource.cacheSchedules(schedules);
        return Success(schedules);
      } on DioError catch (e) {
        return Error(
            APIFailure(e.response?.data['detail'] ?? "Đã có lỗi xảy ra"));
      }
    } else {
      return Success(await _localSource.getListSchedule());
    }
  }
}
