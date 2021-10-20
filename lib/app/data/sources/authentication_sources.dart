import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/session_model.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:get_it/get_it.dart';

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
}
