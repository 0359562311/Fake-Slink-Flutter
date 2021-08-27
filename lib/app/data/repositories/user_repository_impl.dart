import 'package:fakeslink/app/data/sources/user_sources.dart';
import 'package:fakeslink/app/domain/entities/user.dart';
import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteSouce remoteSource;
  UserRepositoryImpl(this.remoteSource);
  @override
  Future<GPA> getGPA() => remoteSource.getGPA();

  @override
  Future<CustomUser> getProfile() => remoteSource.getProfile();

  @override
  Future<CustomUser> updateProfile(String avatar, String cover, String address, String phoneNumber) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}