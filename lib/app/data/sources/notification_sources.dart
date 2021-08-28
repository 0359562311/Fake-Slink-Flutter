import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/one_signal_id.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';

abstract class NotificationSource {
  Future<void> createNotificationDevice(String deviceId, OneSignalId oneSignalId);
  Future<void> deleteNotificationDevice(String deviceId);
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
}