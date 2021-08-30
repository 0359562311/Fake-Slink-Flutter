import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/schedule_model.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';

abstract class ScheduleSource {
  Future<List<ScheduleModel>> getListSchedule();
}

class ScheduleRemoteSource extends ScheduleSource{
  @override
  Future<List<ScheduleModel>> getListSchedule() async {
    final res = await GetIt.instance<Dio>().get(APIPath.listSchedules);
    return (res.data as List).map((e) => ScheduleModel.fromJson(e)).toList();
  }
}