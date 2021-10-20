import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/session_model.dart';
import 'package:fakeslink/app/data/repositories/authentication_repository_impl.dart';
import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../main_test.dart';
import '../../../main_test.mocks.dart';
import 'authentication_repository_impl_test.mocks.dart';

@GenerateMocks([AuthenticationRemoteSource, AuthenticationLocalSource])
void main() {
  late AuthenticationRepositoryImpl repositoryImpl;
  late MockAuthenticationLocalSource localSource;
  late MockAuthenticationRemoteSource remoteSource;
  late MockNetworkInfo networkInfo;
  setUpAll(() {
    registerDependencies();
    localSource = MockAuthenticationLocalSource();
    remoteSource = MockAuthenticationRemoteSource();
    networkInfo = GetIt.instance<MockNetworkInfo>();
    repositoryImpl =
        new AuthenticationRepositoryImpl(remoteSource, localSource);
  });
  tearDownAll(() => unregisterDependencies());
  test('return Network Failure when there is no internet connection', () async {
    when(networkInfo.isConnecting).thenReturn(false);

    final res = await repositoryImpl.logIn("any", "any");

    expect(res, Error(NetworkFailure()));
  });

  group('when network is on', () {
    setUp(() => when(networkInfo.isConnecting).thenReturn(true));
    test('wrong credentials', () async {
      final options = RequestOptions(path: APIPath.logIn);

      when(remoteSource.logIn(any, any)).thenThrow(DioError(
          requestOptions: options,
          response:
              Response(data: {"detail": "any"}, requestOptions: options)));

      final res = await repositoryImpl.logIn("", "");

      expect(res.isError(), true);
      expect(res.getError(), APIFailure("any"));
      verify(remoteSource.logIn("", ""));
    });

    test('right credentials', () async {
      final model = SessionModel.fromJson({"access": "", "refresh": ""});
      when(remoteSource.logIn(any, any))
          .thenAnswer((realInvocation) async => model);

      final res = await repositoryImpl.logIn("", "");

      expect(res.isSuccess(), true);
      expect(res.getSuccess(), model);
      verify(localSource.cacheSession(model));
      verify(remoteSource.logIn("", ""));
    });
  });
}
