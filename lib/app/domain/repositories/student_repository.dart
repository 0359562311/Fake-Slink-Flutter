import 'dart:io';

import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class StudentRepository {
  Future<Result<Failure, Student>> getProfile();
  Future<Result<Failure, Student>> updateProfile(String address, String phoneNumber);
  Future<Result<Failure, Student>> updateAvatar(File file);
}
