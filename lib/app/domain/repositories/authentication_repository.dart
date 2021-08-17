import 'package:fakeslink/app/domain/entities/session.dart';

abstract class AuthenticationRepository {
  Future<Session> logIn(String username, String password);
}