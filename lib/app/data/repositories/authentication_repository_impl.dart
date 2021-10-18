import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteSource _remoteSource;
  final AuthenticationLocalSource _localSource;

  AuthenticationRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Result<Failure, Session>> logIn(
      String username, String password) async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final res = await _remoteSource.logIn(username, password);
        _localSource.cacheSession(res);
        return Success(res);
      } on DioError catch (e) {
        return Error(
            APIFailure(e.response?.data['detail'] ?? "Da co loi xay ra"));
      }
    } else {
      return Error(NetworkFailure());
    }
  }
}
