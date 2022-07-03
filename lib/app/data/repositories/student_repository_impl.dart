import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/student_sources.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

class StudentRepositoryImpl extends StudentRepository {
  final StudentRemoteSouce _remoteSource;
  final StudentLocalSource _localSource;
  StudentRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Result<Failure, Student>> getProfile() async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final user = await _remoteSource.getProfile();
        _localSource.cacheUser(user);
        if (GetIt.instance.isRegistered<Student>())
          GetIt.instance.unregister<Student>();
        GetIt.instance.registerSingleton<Student>(user);
        return Success(user);
      } on DioError catch (e) {
        if (e.response?.statusCode == 401)
          return Error(APIFailure("Phiên đăng nhập đã hết."));
        return Error(APIFailure(e.response?.data['detail'] ?? ""));
      }
    } else {
      final res = await _localSource.getProfile();
      return res == null ? Error(CacheFailure("")) : Success(res);
    }
  }

  @override
  Future<Result<Failure, Student>> updateProfile(String address, String phoneNumber) async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final user = await _remoteSource.updateProfile(address, phoneNumber);
        _localSource.cacheUser(user);
        if (GetIt.instance.isRegistered<Student>())
          GetIt.instance.unregister<Student>();
        GetIt.instance.registerSingleton<Student>(user);
        return Success(user);
      } on DioError catch (e) {
        return Error(APIFailure(e.response?.data['detail'].toString() ?? ""));
      } 
    } else {
      return Error(NetworkFailure());
    }
  }

  @override
  Future<Result<Failure, Student>> updateAvatar(File file) async {
    try {
      final user = await _remoteSource.updateAvatar(file);
      if (GetIt.instance.isRegistered<Student>())
          GetIt.instance.unregister<Student>();
        GetIt.instance.registerSingleton<Student>(user);
      return Success(user);
    } on Exception catch (_) {
      return Error(APIFailure("Không thể cập nhật ảnh đại diện"));
    }
  }
}
