import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';

class LogInUseCase {
  final AuthenticationRepository repository;

  LogInUseCase(this.repository);

  Future<Session> execute(String username, String password) => repository.logIn(username, password);
}