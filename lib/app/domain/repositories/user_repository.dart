import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/entities/student.dart';

abstract class UserRepository {
  Future<Student> getProfile();
  Future<GPA> getGPA();
  Future<Student> updateProfile(String avatar, String cover, String address, String phoneNumber);
}