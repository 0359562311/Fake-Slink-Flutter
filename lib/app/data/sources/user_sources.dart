import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/gpa_model.dart';
import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';

abstract class UserSource {
  Future<StudentModel> getProfile();
  Future<GPAModel> getGPA();
  Future<StudentModel> updateProfile(String avatar, String cover, String address, String phoneNumber);
}

class UserRemoteSouce extends UserSource{
  @override
  Future<GPAModel> getGPA() =>
    GetIt.instance<Dio>().get(APIPath.gpa)
    .then((value) => GPAModel.fromJson(value.data));

  @override
  Future<StudentModel> getProfile() =>
    GetIt.instance<Dio>().get(APIPath.me)
    .then((value) => StudentModel.fromJson(value.data));

  @override
  Future<StudentModel> updateProfile(String avatar, String cover, String address, String phoneNumber) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}