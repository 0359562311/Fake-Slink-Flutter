import 'package:dio/dio.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';

import 'main_test.mocks.dart';

@GenerateMocks([NetworkInfo, DeviceInfo, Dio, SharePreferencesUtils])
void main() {
  setUpAll(registerDependencies);
  tearDownAll(unregisterDependencies);
}

void registerDependencies() {
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  MockDeviceInfo mockDeviceInfo = MockDeviceInfo();
  Dio mockDio = Dio(BaseOptions(baseUrl: "http://localhost:8000"));
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
}

void unregisterDependencies() {
  GetIt.I.unregister<NetworkInfo>();
  GetIt.I.unregister<MockNetworkInfo>();
  GetIt.I.unregister<Dio>();
  GetIt.I.unregister<DioAdapter>();
  GetIt.I.unregister<DeviceInfo>();
  GetIt.I.unregister<MockDeviceInfo>();
  GetIt.I.unregister<MockSharePreferencesUtils>();
}
