import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';

class GetProfileUseCase {
  final StudentRepository repository;
  GetProfileUseCase(this.repository);

  Future<Student?> execute()
    => repository.getProfile();
}