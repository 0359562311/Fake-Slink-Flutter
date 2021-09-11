import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/register_model.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class RegisterRemoteSource {
  Future<List<RegisterModel>> getListRegister() async {
    final response = await GetIt.instance<Dio>().get(APIPath.listRegister);
    return (response.data as List).map((e) => RegisterModel.fromJson(e)).toList();
  }
}

class RegisterLocalSource {
  Future<void> cache(List<Register> registers) async {
    final _box =  await Hive.openBox("register");
    _box.put("data", registers);
  }

  Future<List<Register>> getListRegister() async {
    final _box =  await Hive.openBox("register");
    final res = <Register>[];
    for(var i in _box.get("data",defaultValue: <Register>[])) {
        res.add(i);
    }
    return res;
  }
}