import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/user_repository.dart';

class GetProfileUseCase {
  final UserRepository repository;
  GetProfileUseCase(this.repository);

  Future<Student?> execute()
    => repository.getProfile();
}