import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/utils/local_auth_api.dart';
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
            APIFailure(e.response?.data['detail'] ?? "Đã có lỗi xảy ra"));
      }
    } else {
      return Error(NetworkFailure());
    }
  }

  @override
  Future<Result<Failure, Session>> logInWithFingerprint() async {
    final hasFingerprint = await LocalAuthAPI.hasFingerprint();
    if (!hasFingerprint)
      return Error(PlatformFailure("Thiết bị không hỗ trợ."));

    final setUpFingerprintAuth = await _localSource.getFingerPrintAuthType();
    if (!setUpFingerprintAuth['data'])
      return Error(PlatformFailure("Chưa cài đặt vân tay cho ứng dụng."));
    if (await LocalAuthAPI.authenticate())
      return logIn(
          setUpFingerprintAuth['username'], setUpFingerprintAuth['password']);
    else
      return Error(PlatformFailure("Xác thực thất bại"));
  }

  @override
  Future<Result<Failure, void>> setUpFingerprintAuth(String password) async {
    final checkPassword =
        await logIn(GetIt.instance<Student>().studentId, password);
    if (checkPassword.isError()) return Error(checkPassword.getError()!);
    _localSource.changeFingerPrintAuthType(
        true, GetIt.instance<Student>().studentId, password);
    return Success(null);
  }
}
