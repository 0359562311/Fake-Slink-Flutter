import 'package:fakeslink/app/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({required id, required Details details, required seen, required receiver}) : super(
    details: details,
    id: id,
    receiver: receiver,
    seen: seen
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id : json['id'],
        details : new Details.fromJson(json['details']),
        seen : json['seen'],
        receiver : json['receiver']
    );
  }
}