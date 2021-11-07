import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class LogInWithFingeprintUseCase {
  final AuthenticationRepository _repository;
  const LogInWithFingeprintUseCase(this._repository);

  Future<Result<Failure, Session>> execute() =>
      _repository.logInWithFingerprint();
}
