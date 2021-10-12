import 'package:fakeslink/app/data/sources/notification_sources.dart';
import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';
import 'package:fakeslink/core/utils/network_info.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteSource _remoteSource;
  final NotificationLocalSource _localSource;
  NotificationRepositoryImpl(this._remoteSource, this._localSource);
  @override
  Future<void> createNotificationDevice(String deviceId, String oneSignalId) =>
      _remoteSource.createNotificationDevice(deviceId, oneSignalId);

  @override
  Future<void> deleteNotificationDevice(String deviceId) =>
      _remoteSource.deleteNotificationDevice(deviceId);

  @override
  Future<List<Notification>> getListNotifications(
      int offset, String type) async {
    if (NetworkInfo.isConnecting) {
      final res = await _remoteSource.getListNotifications(offset, type);
      if (res.isNotEmpty) _localSource.cache(res, offset, type);
      return res;
    } else {
      final res = _localSource.getListNotifications(offset, type);
      return res;
    }
  }

  @override
  Future<void> markeAsRead(NotificationDetails details) {
    return _remoteSource.markAsRead(details);
  }
}
