import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class SetUpFingerPrintAuth {
  final AuthenticationRepository _repository;
  const SetUpFingerPrintAuth(this._repository);

  Future<Result<Failure, void>> execute(String password) =>
      _repository.setUpFingerprintAuth(password);
}
