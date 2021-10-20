import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class GetListNotificationsUseCase {
  final NotificationRepository repository;
  GetListNotificationsUseCase(
    this.repository,
  );

  Future<Result<Failure, List<Notification>>> execute(
          int offset, String type) =>
      repository.getListNotifications(offset, type);
}
