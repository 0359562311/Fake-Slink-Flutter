import 'dart:io';

import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateAvatarUseCase {
  final StudentRepository _repository;
  const UpdateAvatarUseCase(this._repository);

  Future<Result<Failure, Student>> execute(File file) => _repository.updateAvatar(file);
}