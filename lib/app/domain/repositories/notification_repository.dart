import 'package:fakeslink/app/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<void> createNotificationDevice(String deviceId, String oneSignalId);
  Future<void> deleteNotificationDevice(String deviceId);
  Future<List<Notification>> getListNotifications(int offset, String type);
  Future<void> markeAsRead(NotificationDetails details);
}