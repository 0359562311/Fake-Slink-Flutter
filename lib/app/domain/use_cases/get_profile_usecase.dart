import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class GetProfileUseCase {
  final StudentRepository repository;
  GetProfileUseCase(this.repository);

  Future<Result<Failure, Student>> execute() => repository.getProfile();
}
