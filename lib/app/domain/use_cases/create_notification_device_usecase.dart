import 'package:fakeslink/app/domain/entities/one_signal_id.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';

class CreateNotificationDeviceUseCase {
  final NotificationRepository repository;

  CreateNotificationDeviceUseCase(this.repository);

  Future<void> execute(String deviceId, OneSignalId oneSignalId)
    => repository.createNotificationDevice(deviceId, oneSignalId);
}