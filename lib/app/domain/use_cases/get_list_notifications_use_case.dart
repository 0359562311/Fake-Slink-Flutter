import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';

class GetListNotificationsUseCase {
  final NotificationRepository repository;
  GetListNotificationsUseCase(
    this.repository,
  );

  Future<List<Notification>> execute(int offset, String type) => repository.getListNotifications(offset, type);
}
