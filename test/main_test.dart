import 'package:dio/dio.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';

import 'main_test.mocks.dart';

@GenerateMocks([NetworkInfo, DeviceInfo, Dio])
void main() {
//   registerDependencies();
// test("test", () {
//   final t = NetworkInfo();
//   when(t.isConnecting).thenReturn(false);
//   expect(t.isConnecting, false);
//   verifyNoMoreInteractions(t);
// });
}

void registerDependencies() {
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  MockDeviceInfo mockDeviceInfo = MockDeviceInfo();
  GetIt.I.registerSingleton<NetworkInfo>(mockNetworkInfo);
  GetIt.I.registerSingleton<MockNetworkInfo>(mockNetworkInfo);
  GetIt.I.registerSingleton<Dio>(MockDio());
  GetIt.I.registerSingleton<DeviceInfo>(mockDeviceInfo);
}

void unregisterDependencies() {
  GetIt.I.unregister<NetworkInfo>();
  GetIt.I.unregister<MockNetworkInfo>();
  GetIt.I.unregister<Dio>();
  GetIt.I.unregister<DeviceInfo>();
}
