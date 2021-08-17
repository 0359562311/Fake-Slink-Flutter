import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/session_model.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:get_it/get_it.dart';

abstract class AuthenticationSource {
  Future<SessionModel> logIn(String username, String password);
}

class AuthenticationRemoteSource extends AuthenticationSource {
  @override
  Future<SessionModel> logIn(String username, String password) async {
    // TODO: implement logIn
    final response = await GetIt.instance<Dio>().post(APIPath.logIn, data: {
      "username": username,
      "password": password
    });
    return SessionModel.fromResponse(response);
  }
}