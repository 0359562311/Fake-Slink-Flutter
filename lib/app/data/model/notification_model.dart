import 'package:fakeslink/app/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({required id, required NotificationDetails details, required seen, required receiver}) : super(
    details: details,
    id: id,
    receiver: receiver,
    seen: seen
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id : json['id'],
        details : new NotificationDetails.fromJson(json['details']),
        seen : json['seen'],
        receiver : json['receiver']
    );
  }
}