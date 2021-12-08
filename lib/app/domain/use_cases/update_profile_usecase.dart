import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateProfileUseCase {
  final StudentRepository _repository;
  const UpdateProfileUseCase(this._repository);

  Future<Result<Failure, Student>> execute(
          String address, String phoneNumber) =>
      _repository.updateProfile(address, phoneNumber);
}
