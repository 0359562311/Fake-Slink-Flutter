import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class NotificationRepository {
  Future<Result<void, void>> createNotificationDevice(
      String deviceId, String oneSignalId);
  Future<Result<void, void>> deleteNotificationDevice(String deviceId);
  Future<Result<Failure, List<Notification>>> getListNotifications(
      int offset, String type);
  Future<Result<void, void>> markeAsRead(NotificationDetails details);
}
