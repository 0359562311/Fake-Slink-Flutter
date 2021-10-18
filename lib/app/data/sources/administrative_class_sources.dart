import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/administrative_class_details_model.dart';
import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class AdministrativeClassRemoteSource {
  Future<AdministrativeClassDetailsModel> getDetails() async {
    Student student = GetIt.instance();
    final res = await GetIt.instance<Dio>()
        .get("/administrative-class/${student.administrativeClass.id}");
    return AdministrativeClassDetailsModel.fromJson(res.data);
  }
}

class AdministrativeClassLocalSource {
  Future<AdministrativeClassDetails?> getDetails() async {
    final _box = await Hive.openBox("administrativeClassDetails");
    return _box.get("data");
  }

  Future<void> cache(AdministrativeClassDetails model) async {
    final _box = await Hive.openBox("administrativeClassDetails");
    _box.put("data", model);
  }
}
