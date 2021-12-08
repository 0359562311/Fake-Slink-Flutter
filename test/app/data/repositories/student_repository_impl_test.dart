import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/data/repositories/student_repository_impl.dart';
import 'package:fakeslink/app/data/sources/student_sources.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../main_test.dart';
import '../../../main_test.mocks.dart';
import 'student_repository_impl_test.mocks.dart';

@GenerateMocks([StudentRemoteSouce, StudentLocalSource, StudentModel])
void main() {
  late StudentRepositoryImpl repositoryImpl;
  late MockStudentLocalSource localSource;
  late MockStudentRemoteSouce remoteSource;
  late MockNetworkInfo networkInfo;
  setUp(() {
    registerDependencies();
    localSource = MockStudentLocalSource();
    remoteSource = MockStudentRemoteSouce();
    networkInfo = GetIt.instance<MockNetworkInfo>();
    repositoryImpl = new StudentRepositoryImpl(remoteSource, localSource);
  });
  tearDown(() => unregisterDependencies());
  group('get Profile test', () {
    test('network is on and get result', () async {
      // Arrange
      when(networkInfo.isConnecting).thenReturn(true);
      when(remoteSource.getProfile())
          .thenAnswer((realInvocation) async => MockStudentModel());
      when(localSource.cacheUser(any))
          .thenAnswer((realInvocation) async => null);
      // Action
      final res = await repositoryImpl.getProfile();
      // Assert
      expect(res.isSuccess(), true);
      verify(localSource.cacheUser(any));
      verify(remoteSource.getProfile());
    });
    test('network is on and get error', () async {
      // Arrange
      when(networkInfo.isConnecting).thenReturn(true);
      when(remoteSource.getProfile())
          .thenThrow(DioError(requestOptions: RequestOptions(path: "path")));
      // Action
      final res = await repositoryImpl.getProfile();
      // Assert
      expect(res.isError(), true);
      expect(res.getError(), TypeMatcher<APIFailure>());
      verify(remoteSource.getProfile());
    });
    test('network is off and cache successful', () async {
      // Arrange
      when(networkInfo.isConnecting).thenReturn(false);
      when(localSource.getProfile())
          .thenAnswer((_) async => MockStudentModel());
      // Action
      final res = await repositoryImpl.getProfile();
      // Assert
      expect(res.isSuccess(), true);
      expect(res.getSuccess(), TypeMatcher<MockStudentModel>());
    });
    test('network is off and cache fail', () async {
      // Arrange
      when(networkInfo.isConnecting).thenReturn(false);
      when(localSource.getProfile()).thenAnswer((_) async => null);
      // Action
      final res = await repositoryImpl.getProfile();
      // Assert
      expect(res.isSuccess(), false);
      expect(res.getError(), TypeMatcher<CacheFailure>());
    });
  });

  test('update profile successful', () async {
    // Arrange
    when(networkInfo.isConnecting).thenReturn(true);
    when(remoteSource.updateProfile(any, any, any, any))
        .thenAnswer((realInvocation) async => MockStudentModel());
    // Action
    final res = await repositoryImpl.updateProfile(
        any, "cover", "address", "phoneNumber");
    // Assert
    expect(res.isSuccess(), true);
    verify(remoteSource.updateProfile(any, any, any, any)).called(1);
    verifyNoMoreInteractions(remoteSource);
  });

  test('update profile fail on making request', () async {
    // Arrange
    when(networkInfo.isConnecting).thenReturn(true);
    when(remoteSource.updateProfile(any, any, any, any))
        .thenThrow(DioError(requestOptions: RequestOptions(path: "")));
    // Action
    final res = await repositoryImpl.updateProfile(
        any, "cover", "address", "phoneNumber");
    // Assert
    expect(res.isError(), true);
    expect(res.getError(), TypeMatcher<APIFailure>());
    verifyZeroInteractions(localSource);
    verify(remoteSource.updateProfile(any, any, any, any));
    verifyNoMoreInteractions(remoteSource);
  });
}
