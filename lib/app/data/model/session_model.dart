import 'package:fakeslink/app/domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel._(String access, String refresh) : super(access: access, refresh: refresh);
  factory SessionModel.fromJson(Map<String,dynamic> json) =>
      SessionModel._(
        json['access'],
        json['refresh'],
      );
}