import 'package:fakeslink/app/domain/repositories/notification_repository.dart';

class CreateNotificationDeviceUseCase {
  final NotificationRepository repository;

  CreateNotificationDeviceUseCase(this.repository);

  Future<void> execute(String deviceId, String playerId) 
    => repository.createNotificationDevice(deviceId, playerId);
}