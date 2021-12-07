import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/notification_model.dart';
import 'package:fakeslink/app/data/repositories/notification_repository_impl.dart';
import 'package:fakeslink/app/data/sources/notification_sources.dart';
import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../main_test.dart';
import '../../../main_test.mocks.dart';
import 'notification_repository_impl_test.mocks.dart';

class MockNotificationModel extends Mock implements NotificationModel {}

@GenerateMocks(
    [NotificationLocalSource, NotificationRemoteSource, NotificationDetails])
void main() {
  late NotificationRepositoryImpl repositoryImpl;
  late MockNotificationLocalSource localSource;
  late MockNotificationRemoteSource remoteSource;
  late MockNetworkInfo networkInfo;
  setUp(() {
    registerDependencies();
    localSource = MockNotificationLocalSource();
    remoteSource = MockNotificationRemoteSource();
    networkInfo = GetIt.instance<MockNetworkInfo>();
    repositoryImpl = new NotificationRepositoryImpl(remoteSource, localSource);
  });
  tearDown(() {
    unregisterDependencies();
  });

  group('get notifications', () {
    test('when network is on and get notifications successfully', () async {
      // Arrange
      when(networkInfo.isConnecting).thenReturn(true);
      when(remoteSource.getListNotifications(any, any))
          .thenAnswer((realInvocation) async => [MockNotificationModel()]);
      when(localSource.cache(any, any, any))
          .thenAnswer((realInvocation) async => null);
      // Action
      final res = await repositoryImpl.getListNotifications(10, "type");
      // Assert
      expect(res.isSuccess(), true);
      expect(res.getSuccess(), TypeMatcher<List<Notification>>());
      verify(localSource.cache(any, any, any));
      verify(remoteSource.getListNotifications(any, any));
    });

    test('when network is on and get notifications fail', () async {
      // Arrange
      when(networkInfo.isConnecting).thenReturn(true);
      when(remoteSource.getListNotifications(any, any)).thenThrow(DioError(
          requestOptions: RequestOptions(path: APIPath.listNotifications)));
      // Action
      final res = await repositoryImpl.getListNotifications(10, "type");
      // Assert
      expect(res.isError(), true);
      expect(res.getError(), TypeMatcher<APIFailure>());
    });

    test('when network is off return caching data', () async {
      // Arrange
      when(networkInfo.isConnecting).thenReturn(false);
      when(localSource.getListNotifications(any, any))
          .thenAnswer((realInvocation) async => [MockNotificationModel()]);
      // Action
      final res = await repositoryImpl.getListNotifications(0, "type");
      // Assert
      expect(res.isSuccess(), true);
      expect(res.getSuccess(), TypeMatcher<List<Notification>>());
    });
  });

  test('create notification device', () async {
    // Arrange
    when(networkInfo.isConnecting).thenReturn(true);
    // Action
    await repositoryImpl.createNotificationDevice("deviceId", "oneSignalId");
    // Assert
    verify(remoteSource.createNotificationDevice(any, any));
    verifyZeroInteractions(localSource);
  });

  test('delete notification device', () async {
    // Arrange
    when(networkInfo.isConnecting).thenReturn(true);
    // Action
    await repositoryImpl.deleteNotificationDevice("deviceId");
    // Assert
    verify(remoteSource.deleteNotificationDevice(any));
    verifyZeroInteractions(localSource);
    verifyNoMoreInteractions(remoteSource);
  });

  test('mark as seen', () async {
    // Arrange
    when(networkInfo.isConnecting).thenReturn(true);
    // Action
    await repositoryImpl.markeAsRead(MockNotificationDetails());
    // Assert
    verify(remoteSource.markAsRead(any));
    verifyZeroInteractions(localSource);
    verifyNoMoreInteractions(remoteSource);
  });
}
