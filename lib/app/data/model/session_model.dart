import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel._(String access, String refresh) : super(access: access, refresh: refresh);
  factory SessionModel.fromResponse(Response response) =>
      SessionModel._(
        response.data['access'],
        response.data['refresh'],
      );
}