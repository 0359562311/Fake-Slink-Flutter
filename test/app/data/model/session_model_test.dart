import 'package:fakeslink/app/data/model/session_model.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Session session = Session(access: "ngu", refresh: "hehe");
  test('session model from json is right', () {
    final model = SessionModel.fromJson({"access": "ngu", "refresh": "hehe"});
    expect(model, isA<Session>());
    expect(session, model);
  });

  group("session model fron json is wrong", () {
    test('access is wrong', () {
      final model = SessionModel.fromJson({"access": "ng", "refresh": "hehe"});
      expect(session == model, false);
    });
    test('refresh is wrong', () {
      final model = SessionModel.fromJson({"access": "ngu", "refresh": "hhe"});
      expect(session == model, false);
    });
    test('both is wrong', () {
      final model = SessionModel.fromJson({"access": "nu", "refresh": "hee"});
      expect(session == model, false);
    });
  });
}
