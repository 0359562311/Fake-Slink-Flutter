import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/notification_model.dart';
import 'package:fakeslink/app/domain/entities/one_signal_id.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';

abstract class NotificationSource {
  Future<void> createNotificationDevice(String deviceId, OneSignalId oneSignalId);
  Future<void> deleteNotificationDevice(String deviceId);
  Future<List<NotificationModel>> getListNotifications(int offset, String type);
}

class NotificationRemoteSource extends NotificationSource {
  @override
  Future<void> createNotificationDevice(String deviceId, OneSignalId oneSignalId) async {
    GetIt.instance<Dio>().post(APIPath.notificationDevice, data: {
      "device_id": deviceId,
      "player_id": oneSignalId.id+"7"
    });
  }

  @override
  Future<void> deleteNotificationDevice(String deviceId) async {
    GetIt.instance<Dio>().delete(APIPath.notificationDevice, data: {
      "device_id": deviceId,
    });
  }

  @override
  Future<List<NotificationModel>> getListNotifications(int offset, String type) async {
    final response = await GetIt.instance<Dio>().get(APIPath.listNotifications,queryParameters: {
      "type": type,
      "limit": 10,
      "offset": offset
    });
    return (response.data['results'] as List).map((e) => NotificationModel.fromJson(e)).toList();
  }
}