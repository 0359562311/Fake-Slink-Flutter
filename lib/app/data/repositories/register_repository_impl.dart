import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/register_source.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterLocalSource _localSource;
  final RegisterRemoteSource _remoteSource;

  RegisterRepositoryImpl(this._localSource, this._remoteSource);

  @override
  Future<Result<Failure, List<Register>>> getListRegister() async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final res = await _remoteSource.getListRegister();
        _localSource.cacheListRegisters(res);
        return Success(res);
      } on DioError catch (e) {
        return Error(
            APIFailure(e.response?.data['detail'] ?? "Đã có lỗi xảy ra"));
      }
    } else {
      return Success(await _localSource.getListRegister());
    }
  }

  @override
  Future<Result<Failure, RegisterableClass>> getDetails(
      int registerableClassId) async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final res = await _remoteSource.getDetails(registerableClassId);
        _localSource.cacheRegisterableClassDetails(res);
        return Success(res);
      } on DioError catch (e) {
        return Error(e.response?.data['detail'] ?? "Đã có lỗi xảy ra");
      }
    } else {
      final res = await _localSource.getDetails(registerableClassId);
      if (res != null) return Success(res);
      return Error(CacheFailure(""));
    }
  }
}
