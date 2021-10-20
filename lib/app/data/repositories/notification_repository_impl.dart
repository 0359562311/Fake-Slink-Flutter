import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/sources/notification_sources.dart';
import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteSource _remoteSource;
  final NotificationLocalSource _localSource;
  NotificationRepositoryImpl(this._remoteSource, this._localSource);
  @override
  Future<Result<void, void>> createNotificationDevice(
      String deviceId, String oneSignalId) async {
    try {
      _remoteSource.createNotificationDevice(deviceId, oneSignalId);
      return Success(null);
    } on DioError catch (_) {
      return Error(null);
    }
  }

  @override
  Future<Result<void, void>> deleteNotificationDevice(String deviceId) async {
    try {
      _remoteSource.deleteNotificationDevice(deviceId);
      return Success(null);
    } on DioError catch (_) {
      return Error(null);
    }
  }

  @override
  Future<Result<Failure, List<Notification>>> getListNotifications(
      int offset, String type) async {
    if (GetIt.instance<NetworkInfo>().isConnecting) {
      try {
        final res = await _remoteSource.getListNotifications(offset, type);
        if (res.isNotEmpty) _localSource.cache(res, offset, type);
        return Success(res);
      } on DioError catch (e) {
        return Error(
            APIFailure(e.response?.data['detail'] ?? "Đã có lỗi xảy ra"));
      }
    } else {
      return Success(await _localSource.getListNotifications(offset, type));
    }
  }

  @override
  Future<Result<void, void>> markeAsRead(NotificationDetails details) async {
    try {
      _remoteSource.markAsRead(details);
      return Success(null);
    } on DioError catch (_) {
      return Error(null);
    }
  }
}
