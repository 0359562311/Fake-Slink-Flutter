import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/entities/one_signal_id.dart';
import 'package:fakeslink/app/presentation/notifications/ui/notification_details.dart';

abstract class NotificationRepository {
  Future<void> createNotificationDevice(String deviceId, OneSignalId oneSignalId);
  Future<void> deleteNotificationDevice(String deviceId);
  Future<List<Notification>> getListNotifications(int offset, String type);
  Future<void> markeAsRead(NotificationDetails details);
}