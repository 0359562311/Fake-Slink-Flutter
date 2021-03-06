import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/register_model.dart';
import 'package:fakeslink/app/data/model/registerable_class_model.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class RegisterRemoteSource {
  Future<List<RegisterModel>> getListRegister() async {
    final response = await GetIt.instance<Dio>().get(APIPath.listRegister);
    return (response.data as List)
        .map((e) => RegisterModel.fromJson(e))
        .toList();
  }

  Future<RegisterableClassModel> getDetails(int id) async {
    final response = await GetIt.instance<Dio>().get("/registerable-class/$id");
    return RegisterableClassModel.fromJson(response.data);
  }
}

class RegisterLocalSource {
  Future<void> cacheListRegisters(List<Register> registers) async {
    final _box = await GetIt.instance<HiveInterface>().openBox("register");
    _box.put("data", registers);
  }

  Future<List<Register>> getListRegister() async {
    final _box = await GetIt.instance<HiveInterface>().openBox("register");
    final res = <Register>[];
    for (var i in _box.get("data", defaultValue: <Register>[])) {
      res.add(i);
    }
    return res;
  }

  Future<RegisterableClass?> getDetails(int id) async {
    final _box = await GetIt.instance<HiveInterface>()
        .openBox("registerableClassDetails");
    return _box.get(id, defaultValue: null);
  }

  Future<void> cacheRegisterableClassDetails(
      RegisterableClass registerableClass) async {
    final _box = await GetIt.instance<HiveInterface>().openBox("register");
    _box.put(registerableClass.id, registerableClass);
  }
}
