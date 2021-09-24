import 'package:fakeslink/app/domain/repositories/notification_repository.dart';

class CreateNotificationDeviceUseCase {
  final NotificationRepository repository;

  CreateNotificationDeviceUseCase(this.repository);

  Future<void> execute(String deviceId, String oneSignalId)
    => repository.createNotificationDevice(deviceId, oneSignalId);
}