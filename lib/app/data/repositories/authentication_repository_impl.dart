import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteSource _remoteSource;
  final AuthenticationLocalSource _localSource;

  AuthenticationRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Session> logIn(String username, String password) async {
    final res = await _remoteSource.logIn(username, password);
    _localSource.cacheSession(res);
    return res;
  }

}