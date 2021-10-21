import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/administrative_class_sources.dart';
import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';
import 'package:fakeslink/app/domain/repositories/administrative_class_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

class AdministrativeClassReporitoryImpl extends AdministrativeClassRepository {
  final AdministrativeClassRemoteSource _remoteSource;
  final AdministrativeClassLocalSource _localSource;

  AdministrativeClassReporitoryImpl(this._remoteSource, this._localSource);

  @override
  Future<Result<Failure, AdministrativeClassDetails>> getDetails() async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final res = await _remoteSource.getDetails();
        _localSource.cache(res);
        return Success(res);
      } on DioError catch (e) {
        return Error(
            APIFailure(e.response?.data['detail'] ?? "Đã có lỗi xảy ra"));
      }
    } else {
      final res = await _localSource.getDetails();
      if (res != null) return Success(res);
      return Error(CacheFailure("Đã có lỗi xảy ra"));
    }
  }
}
