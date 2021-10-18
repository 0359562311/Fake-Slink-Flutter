import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/student_sources.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';

class StudentRepositoryImpl extends StudentRepository {
  final StudentRemoteSouce _remoteSource;
  final StudentLocalSource _localSource;
  StudentRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Student?> getProfile() async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final user = await _remoteSource.getProfile();
        _localSource.cacheUser(user);
        if (GetIt.instance.isRegistered<Student>())
          GetIt.instance.unregister<Student>();
        GetIt.instance.registerSingleton<Student>(user);
        return user;
      } on DioError {
        return _localSource.getProfile();
      }
    } else {
      return _localSource.getProfile();
    }
  }

  @override
  Future<Student> updateProfile(
      String avatar, String cover, String address, String phoneNumber) {
    throw UnimplementedError();
  }
}
