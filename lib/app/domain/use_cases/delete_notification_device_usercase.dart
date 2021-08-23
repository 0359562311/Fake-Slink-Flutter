import 'package:fakeslink/app/domain/repositories/notification_repository.dart';

class DeleteNotificationDeviceUseCase {
  final NotificationRepository repository;

  DeleteNotificationDeviceUseCase(this.repository);

  Future<void> execute(String deviceId) 
    => repository.deleteNotificationDevice(deviceId);
}