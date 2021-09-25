import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/register_source.dart';
import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/entities/registerable_class_details.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';
import 'package:fakeslink/core/utils/network_info.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterLocalSource _localSource;
  final RegisterRemoteSource _remoteSource;

  RegisterRepositoryImpl(this._localSource, this._remoteSource);

  @override
  Future<Pair<String, List<Register>>> getListRegister() async {
    if (NetworkInfo.isConnecting) {
      try {
        final res = await _remoteSource.getListRegister();
        _localSource.cache(res);
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
  Future<RegisterableClassDetails> getDetails(int registerableClassId) {
    return _remoteSource.getDetails(registerableClassId);
  }
}
