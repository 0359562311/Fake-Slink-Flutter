import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/administrative_class_sources.dart';
import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';
import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/repositories/administrative_class_repository.dart';
import 'package:fakeslink/core/utils/network_info.dart';

class AdministrativeClassReporitoryImpl extends AdministrativeClassRepository {
  final AdministrativeClassRemoteSource _remoteSource;
  final AdministrativeClassLocalSource _localSource;

  AdministrativeClassReporitoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Pair<String,AdministrativeClassDetails>> getDetails() async {
    if(NetworkInfo.isConnecting) {
      try {
        final res = await _remoteSource.getDetails();
        _localSource.cache(res);
        return Pair(result: res);
      } on DioError catch (e) {
        return Pair(error: e.response?.data['detail']??"Đã có lỗi xảy ra");
      }
    } else {
      return Pair(result: await _localSource.getDetails());
    }
  }
}