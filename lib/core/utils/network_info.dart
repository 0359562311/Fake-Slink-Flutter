import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo{
  static bool isConnecting = false;
  static Future<void> init() async {
    NetworkInfo.isConnecting = (await Connectivity().checkConnectivity()) != ConnectivityResult.none;
  }
}