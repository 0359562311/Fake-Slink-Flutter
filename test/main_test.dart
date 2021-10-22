import 'package:dio/dio.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';

import 'main_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  DeviceInfo,
  Dio,
  DioError,
  SharePreferencesUtils,
  HiveInterface,
  Box
])
void main() {
  setUpAll(registerDependencies);
  tearDownAll(unregisterDependencies);
}

void registerDependencies() {
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  MockDeviceInfo mockDeviceInfo = MockDeviceInfo();
  Dio mockDio = Dio(BaseOptions(baseUrl: "http://localhost:8000"));
  MockHiveInterface mockHive = MockHiveInterface();
  MockBox mockBox = MockBox();
  MockSharePreferencesUtils mockSharePreferencesUtils =
      MockSharePreferencesUtils();
  GetIt.I.registerSingleton<NetworkInfo>(mockNetworkInfo);
  GetIt.I.registerSingleton<MockNetworkInfo>(mockNetworkInfo);
  GetIt.I.registerSingleton<Dio>(mockDio);
  // Dio dio = Dio(BaseOptions());
  // DioAdapter dioAdapter = DioAdapter(dio: dio);
  GetIt.I.registerSingleton<DioAdapter>(DioAdapter(dio: mockDio));
  GetIt.I.registerSingleton<DeviceInfo>(mockDeviceInfo);
  GetIt.I.registerSingleton<MockDeviceInfo>(mockDeviceInfo);
  GetIt.I
      .registerSingleton<MockSharePreferencesUtils>(mockSharePreferencesUtils);
  GetIt.I.registerSingleton<SharePreferencesUtils>(mockSharePreferencesUtils);
  GetIt.I.registerSingleton<HiveInterface>(mockHive);
  GetIt.I.registerSingleton<MockHiveInterface>(mockHive);
  GetIt.I.registerSingleton<Box>(mockBox);
  GetIt.I.registerSingleton<MockBox>(mockBox);
}

void unregisterDependencies() {
  GetIt.I.unregister<NetworkInfo>();
  GetIt.I.unregister<MockNetworkInfo>();
  GetIt.I.unregister<Dio>();
  GetIt.I.unregister<DioAdapter>();
  GetIt.I.unregister<DeviceInfo>();
  GetIt.I.unregister<MockDeviceInfo>();
  GetIt.I.unregister<MockSharePreferencesUtils>();
  GetIt.I.unregister<HiveInterface>();
  GetIt.I.unregister<MockHiveInterface>();
  GetIt.I.unregister<Box>();
  GetIt.I.unregister<MockBox>();
}
