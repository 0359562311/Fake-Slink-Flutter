import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class StudentRemoteSouce {
  Future<StudentModel> getProfile() => GetIt.instance<Dio>()
      .get(APIPath.me)
      .then((value) => StudentModel.fromJson(value.data));

  Future<StudentModel> updateProfile(
      String? avatar, String cover, String address, String phoneNumber) async {
    final res = await GetIt.instance<Dio>().put(APIPath.me, data: {
      if(avatar != null) "avatar": avatar,
      "cover": cover,
      "address": address,
      "phoneNumber": phoneNumber
    });
    return StudentModel.fromJson(res.data);
  }

  Future<String> updateAvatar(File file) async {
    final firebaseStorage = FirebaseStorage.instance;
    await firebaseStorage.ref("avatar/${GetIt.I<Student>().id}.png").putFile(file);
    return firebaseStorage.ref("avatar/${GetIt.I<Student>().id}.png").getDownloadURL();
  }
}

class StudentLocalSource {
  Future<StudentModel?> getProfile() async {
    final _box = await GetIt.instance<HiveInterface>().openBox("user");
    final res = _box.get("data", defaultValue: null);
    return res;
  }

  Future<void> cacheUser(StudentModel studentModel) async {
    final Box _box = await GetIt.instance<HiveInterface>().openBox("user");
    _box.clear();
    _box.put("data", studentModel);
  }
}
