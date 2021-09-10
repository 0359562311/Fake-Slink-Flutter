import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/gpa_model.dart';
import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class UserRemoteSouce {
  
  Future<GPAModel> getGPA() =>
    GetIt.instance<Dio>().get(APIPath.gpa)
    .then((value) => GPAModel.fromJson(value.data));

  Future<StudentModel> getProfile() =>
    GetIt.instance<Dio>().get(APIPath.me)
    .then((value) => StudentModel.fromJson(value.data));

  Future<StudentModel> updateProfile(String avatar, String cover, String address, String phoneNumber) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}

class UserLocalSource {

  Future<Student?> getProfile() async {
    final _box =  await Hive.openBox("user");
    final res = _box.get("data",defaultValue: null);
    return res;
  }
  
  Future<void> cacheUser(StudentModel studentModel) async {
    final Box _box = await Hive.openBox("user");
    _box.clear();
    _box.put("data", studentModel);
  }
}