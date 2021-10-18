import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class LogInUseCase {
  final AuthenticationRepository repository;

  LogInUseCase(this.repository);

  Future<Result<Failure, Session>> execute(String username, String password) =>
      repository.logIn(username, password);
}
