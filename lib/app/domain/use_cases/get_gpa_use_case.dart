import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/repositories/user_repository.dart';

class GetGPAUseCase {
  final UserRepository repository;
  GetGPAUseCase(this.repository);

  Future<GPA> execute() => repository.getGPA();
}