import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/session_model.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class AuthenticationRemoteSource {
  Future<SessionModel> logIn(String username, String password) async {
    final response = await GetIt.instance<Dio>().post(APIPath.logIn,
        data: {"username": username, "password": password});
    return SessionModel.fromJson(response.data);
  }
}

class AuthenticationLocalSource {
  Future<void> cacheSession(SessionModel session) async {
    GetIt.instance<SharePreferencesUtils>().setString("access", session.access);
    GetIt.instance<SharePreferencesUtils>()
        .setString("refresh", session.refresh);
  }

  Future<void> changeFingerPrintAuthType(
      bool b, String username, String password) async {
    final box = await GetIt.instance<HiveInterface>().openBox("fingerprint");
    box.put("data", b);
    box.put("username", username);
    box.put("password", password);
  }

  Future<Map<String, dynamic>> getFingerPrintAuthType() async {
    final box = await GetIt.instance<HiveInterface>().openBox("fingerprint");
    return {
      "data": box.get("data") ?? false,
      "username": box.get("username"),
      "password": box.get("password")
    };
  }
}
