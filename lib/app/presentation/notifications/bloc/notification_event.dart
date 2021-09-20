import 'package:fakeslink/app/domain/entities/notification.dart';

abstract class NotificationEvent {
  final String type;
  const NotificationEvent(this.type);
}

class NotificationInitEvent extends NotificationEvent{
  NotificationInitEvent(String type): super(type);
}

class NotificationLoadMoreEvent extends NotificationEvent {
  NotificationLoadMoreEvent(String type): super(type);
}

class NotificationMarkAsSeenEvent extends NotificationEvent {
  final NotificationDetails details;
  final int index;
  const NotificationMarkAsSeenEvent(this.details, String type, this.index): super(type);
}