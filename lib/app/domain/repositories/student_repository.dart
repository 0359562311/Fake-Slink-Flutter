import 'package:fakeslink/app/domain/entities/student.dart';

abstract class StudentRepository {
  Future<Student?> getProfile();
  Future<Student> updateProfile(String avatar, String cover, String address, String phoneNumber);
}