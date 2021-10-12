import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/notification_model.dart';
import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class NotificationRemoteSource {
  Future<void> createNotificationDevice(
      String deviceId, String oneSignalId) async {
    GetIt.instance<Dio>().post(APIPath.notificationDevice,
        data: {"device_id": deviceId, "player_id": oneSignalId + "7"});
  }

  Future<void> deleteNotificationDevice(String deviceId) async {
    GetIt.instance<Dio>().delete(APIPath.notificationDevice, data: {
      "device_id": deviceId,
    });
  }

  Future<List<NotificationModel>> getListNotifications(
      int offset, String type) async {
    final response = await GetIt.instance<Dio>().get(APIPath.listNotifications,
        queryParameters: {"type": type, "limit": 10, "offset": offset});
    return (response.data['results'] as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }

  Future<void> markAsRead(NotificationDetails details) async {
    GetIt.instance<Dio>().put("/notification/mark-as-read/${details.id}/");
  }
}

class NotificationLocalSource {
  Future<List<Notification>> getListNotifications(
      int offset, String type) async {
    final _box = await Hive.openBox("notifications");
    final res = <Notification>[];
    for (var i
        in _box.get(type + "offset", defaultValue: <Notification>[]) ?? []) {
      res.add(i);
    }
    return res;
  }

  Future cache(List<Notification> notis, int offset, String type) async {
    Box notiBox = await Hive.openBox("notifications");
    notiBox.put(type + "offset", notis);
  }
}
