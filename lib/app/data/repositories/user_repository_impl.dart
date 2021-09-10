import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/user_sources.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteSouce remoteSource;
  final UserLocalSource localSource;
  UserRepositoryImpl(this.remoteSource, this.localSource);
  @override
  Future<GPA> getGPA() => remoteSource.getGPA();

  @override
  Future<Student?> getProfile() async {
    try {
      final user = await remoteSource.getProfile();
      await localSource.cacheUser(user);
      return user;
    } on DioError catch (e) {
      return localSource.getProfile();
    }
  }

  @override
  Future<Student> updateProfile(String avatar, String cover, String address, String phoneNumber) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}