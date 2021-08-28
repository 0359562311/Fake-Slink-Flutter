import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/gpa_model.dart';
import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/repositories/user_repository.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';

abstract class UserSource extends UserRepository{}

class UserRemoteSouce extends UserSource{
  @override
  Future<GPA> getGPA() => 
    GetIt.instance<Dio>().get(APIPath.gpa)
    .then((value) => GPAModel.fromJson(value.data));

  @override
  Future<Student> getProfile() =>
    GetIt.instance<Dio>().get(APIPath.me)
    .then((value) => StudentModel.fromJson(value.data));

  @override
  Future<Student> updateProfile(String avatar, String cover, String address, String phoneNumber) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}