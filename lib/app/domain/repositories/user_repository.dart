import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/entities/user.dart';

abstract class UserRepository {
  Future<CustomUser> getProfile();
  Future<GPA> getGPA();
  Future<CustomUser> updateProfile(String avatar, String cover, String address, String phoneNumber);
}