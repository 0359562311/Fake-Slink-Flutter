import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/student_sources.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';

class StudentRepositoryImpl extends StudentRepository {
  final StudentRemoteSouce remoteSource;
  final StudentLocalSource localSource;
  StudentRepositoryImpl(this.remoteSource, this.localSource);

  @override
  Future<Student?> getProfile() async {
    try {
      final user = await remoteSource.getProfile();
      await localSource.cacheUser(user);
      return user;
    } on DioError {
      return localSource.getProfile();
    }
  }

  @override
  Future<Student> updateProfile(String avatar, String cover, String address, String phoneNumber) {
    throw UnimplementedError();
  }
}