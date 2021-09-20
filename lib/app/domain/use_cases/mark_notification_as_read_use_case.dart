import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';

class MarkNotificationAsReadUseCase {
  final NotificationRepository _repository;
  const MarkNotificationAsReadUseCase(this._repository);

  Future<void> execute(NotificationDetails details) => _repository.markeAsRead(details);
}