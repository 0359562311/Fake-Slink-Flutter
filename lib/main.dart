import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/repositories/authentication_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/notification_repository_impl.dart';
import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/app/data/sources/notification_sources.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';
import 'package:fakeslink/app/domain/use_cases/create_notification_device_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/presentation/login/ui/login_screen.dart';
import 'package:fakeslink/app/presentation/main_screen.dart';
import 'package:fakeslink/app/presentation/notifications/notification_details.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'app/domain/entities/session.dart';
import 'core/const/app_routes.dart';
import 'core/utils/interceptor.dart';
import 'core/utils/network_info.dart';
import 'core/utils/share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await init();
  runApp(MyApp());
}

Future<void> init() async {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton(GlobalKey<NavigatorState>());
  await DeviceInfo.init();
  await SharePreferencesUtils.init();
  if(SharePreferencesUtils.getString("refresh") != null) {
    getIt.registerSingleton(
        Session(
            access: SharePreferencesUtils.getString("access")!,
            refresh: SharePreferencesUtils.getString("refresh")!
        )
    );
  }
  var options = BaseOptions(
      baseUrl: 'http://192.168.0.101:8000',
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.json
  );
  getIt.registerSingleton<StreamController<String>>(StreamController<String>());
  getIt.registerSingleton(Dio(options)
    ..interceptors.addAll(
        [AuthenticationInterceptor(),
          LogInterceptor(
              requestBody: true, requestHeader: false, responseBody: true,
              request: false, responseHeader: false,error: true
          ),]
    ));

  /// repositories
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getIt()));
  getIt.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(getIt()));

  /// sources
  getIt.registerLazySingleton(() => AuthenticationRemoteSource());
  getIt.registerLazySingleton(() => NotificationRemoteSource());

  /// use cases
  getIt.registerLazySingleton(() => LogInUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateNotificationDeviceUseCase(getIt()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const oneSignalAppId = "1537dc7c-b315-4c3a-a355-9ca677c33fef";
  late final subscription;
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      NetworkInfo.isConnecting = result != ConnectivityResult.none;
    });
    initOneSignal();
  }

  Future<void> initOneSignal() async {
    await OneSignal.shared.setAppId(oneSignalAppId);
    final state = await OneSignal.shared.getDeviceState();
    if(state?.userId != null) {
      GetIt.instance.registerSingleton<String>(state!.userId!);
    }
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      var data = openedResult.notification.additionalData;
      GetIt.instance<GlobalKey<NavigatorState>>().currentState?.pushNamed(AppRoute.notificationDetails,
        arguments: data
      );
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
    });
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      print("TanKiem: setPermissionObserver from ${changes.from.status} to ${changes.to.status}");
    });
    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
      print("TanKiem: setSubscriptionObserver from ${changes.from.pushToken} to ${changes.to.pushToken}");
    });
  }

  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red[900]));
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return true;
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: GetIt.instance.isRegistered<Session>() ? AppRoute.main : AppRoute.login,
        navigatorKey: GetIt.instance<GlobalKey<NavigatorState>>(),
        routes: {
          AppRoute.login: (context) => Login(),
          AppRoute.main: (context) => MainScreen(),
          AppRoute.notificationDetails: (context) => NotificationDetails()
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}