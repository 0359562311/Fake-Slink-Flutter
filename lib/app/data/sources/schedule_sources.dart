import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/schedule_model.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class ScheduleRemoteSource {
  Future<List<ScheduleModel>> getListSchedule() async {
    final res = await GetIt.instance<Dio>().get(APIPath.listSchedules);
    return (res.data as List).map((e) => ScheduleModel.fromJson(e)).toList();
  }
}

class ScheduleLocalSource {
  Future<List<Schedule>> getListSchedule() async {
    final _box = await GetIt.instance<HiveInterface>().openBox("schedules");
    final res = <Schedule>[];
    for (var i in _box.get("data", defaultValue: <Schedule>[])) {
      res.add(i);
    }
    return res;
  }

  Future<void> cacheSchedules(List<ScheduleModel> schedules) async {
    final _box = await GetIt.instance<HiveInterface>().openBox("schedules");
    await _box.clear();
    _box.put("data", schedules);
  }
}
