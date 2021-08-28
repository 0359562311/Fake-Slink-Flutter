import 'package:fakeslink/app/data/sources/user_sources.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteSouce remoteSource;
  UserRepositoryImpl(this.remoteSource);
  @override
  Future<GPA> getGPA() => remoteSource.getGPA();

  @override
  Future<Student> getProfile() => remoteSource.getProfile();

  @override
  Future<Student> updateProfile(String avatar, String cover, String address, String phoneNumber) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}