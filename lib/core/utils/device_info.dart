import 'package:device_info_plus/device_info_plus.dart';

class PlatformInfo{
  static String? deviceId;
  static String? deviceName;

  static Future init() async{
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
      deviceName = androidInfo.device;
    } on Exception catch (e) {
    }
  }
}