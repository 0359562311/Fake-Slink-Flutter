import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AuthenticationRepository {
  Future<Result<Failure, Session>> logIn(String username, String password);
}
