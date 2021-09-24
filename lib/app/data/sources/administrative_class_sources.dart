import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/administrative_class_details_model.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:get_it/get_it.dart';

mixin AdministrativeClassSource {
  Future<AdministrativeClassDetailsModel> getDetails();
}

class AdministrativeClassRemoteSource with AdministrativeClassSource {
  @override
  Future<AdministrativeClassDetailsModel> getDetails() async {
    Student student = GetIt.instance();
    final res = await GetIt.instance<Dio>().get("/administrative-class/${student.administrativeClass.id}");
    return AdministrativeClassDetailsModel.fromJson(res.data);
  }
}