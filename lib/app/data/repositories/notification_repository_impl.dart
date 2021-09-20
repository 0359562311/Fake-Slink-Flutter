import 'package:fakeslink/app/data/sources/notification_sources.dart';
import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/entities/one_signal_id.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteSource remoteSource;
  NotificationRepositoryImpl(this.remoteSource);
  @override
  Future<void> createNotificationDevice(String deviceId, OneSignalId oneSignalId)
    => remoteSource.createNotificationDevice(deviceId, oneSignalId);

  @override
  Future<void> deleteNotificationDevice(String deviceId) 
    => remoteSource.deleteNotificationDevice(deviceId);

  @override
  Future<List<Notification>> getListNotifications(int offset, String type) {
    return remoteSource.getListNotifications(offset, type);
  }

  @override
  Future<void> markeAsRead(NotificationDetails details) {
    return remoteSource.markAsRead(details);
  }

}