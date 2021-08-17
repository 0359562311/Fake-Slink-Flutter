import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteSource remoteSource;

  AuthenticationRepositoryImpl(this.remoteSource);

  @override
  Future<Session> logIn(String username, String password) => remoteSource.logIn(username, password);

}