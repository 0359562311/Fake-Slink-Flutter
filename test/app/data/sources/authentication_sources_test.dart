import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/session_model.dart';
import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import '../../../main_test.dart';
import '../../../main_test.mocks.dart';

void main() {
  late final AuthenticationRemoteSource remoteSource;
  late final DioAdapter dioAdapter;
  late final AuthenticationLocalSource localSource;
  late final MockSharePreferencesUtils mockSharePreferencesUtils;
  setUpAll(() {
    registerDependencies();
    remoteSource = AuthenticationRemoteSource();
    dioAdapter = GetIt.instance();
    localSource = AuthenticationLocalSource();
    mockSharePreferencesUtils = GetIt.instance();
  });
  tearDownAll(() => unregisterDependencies());
  group('authentication remote source', () {
    test('should throw a dio error when user provides wrong credentials', () {
      // Arrange
      dioAdapter.onPost(APIPath.logIn, (server) {
        return server.reply(401, {"detail": ""});
      });
      // Action
      final function = remoteSource.logIn;
      // Assert
      expect(function("", ""), throwsA(TypeMatcher<DioError>()));
    });

    test('should return session model when user provides right credentials',
        () async {
      // Arrange

      final String username = "username";
      final String password = "password";
      final json = {"access": "", "refresh": ""};
      dioAdapter.onPost(APIPath.logIn, (server) {
        return server.reply(200, json);
      }, data: {"username": username, "password": password});
      // Action
      final res = await remoteSource.logIn("username", "password");
      // Assert
      expect(res, SessionModel.fromJson(json));
    });
  });

  test('test name', () {
    // Arrange
    when(mockSharePreferencesUtils.setString("access", any))
        .thenAnswer((_) async => null);
    when(mockSharePreferencesUtils.setString("refresh", any))
        .thenAnswer((_) async => null);
    // Action
    localSource
        .cacheSession(SessionModel.fromJson({"access": "", "refresh": ""}));
    // Assert
    verify(mockSharePreferencesUtils.setString("access", "")).called(1);
    verify(mockSharePreferencesUtils.setString("refresh", "")).called(1);
    verifyNoMoreInteractions(mockSharePreferencesUtils);
  });
}
