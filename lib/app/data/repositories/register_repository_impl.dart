import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/register_source.dart';
import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterLocalSource _localSource;
  final RegisterRemoteSource _remoteSource;

  RegisterRepositoryImpl(this._localSource, this._remoteSource);

  @override
  Future<Pair<String, List<Register>>> getListRegister() async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final res = await _remoteSource.getListRegister();
        _localSource.cacheListRegisters(res);
        return Pair(result: res);
      } on DioError catch (e) {
        return Pair(
            result: await _localSource.getListRegister(),
            error: e.response?.data['detail'] ?? "Đã có lỗi xảy ra");
      }
    } else {
      return Pair(result: await _localSource.getListRegister());
    }
  }

  @override
  Future<Pair<String, RegisterableClass>> getDetails(
      int registerableClassId) async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final res = await _remoteSource.getDetails(registerableClassId);
        _localSource.cacheRegisterableClassDetails(res);
        return Pair(result: res);
      } on DioError catch (e) {
        return Pair(error: e.response?.data['detail'] ?? "Đã có lỗi xảy ra");
      }
    } else {
      return Pair(result: await _localSource.getDetails(registerableClassId));
    }
  }
}
