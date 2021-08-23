abstract class NotificationRepository {
  Future<void> createNotificationDevice(String deviceId, String playerId);
  Future<void> deleteNotificationDevice(String deviceId);
}