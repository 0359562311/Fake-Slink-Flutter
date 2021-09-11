import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/repositories/authentication_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/notification_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/register_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/schedule_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/student_repository_impl.dart';
import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/app/data/sources/notification_sources.dart';
import 'package:fakeslink/app/data/sources/register_source.dart';
import 'package:fakeslink/app/data/sources/schedule_sources.dart';
import 'package:fakeslink/app/data/sources/student_sources.dart';
import 'package:fakeslink/app/domain/entities/lecturer.dart';
import 'package:fakeslink/app/domain/entities/one_signal_id.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/entities/subject.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';
import 'package:fakeslink/app/domain/use_cases/create_notification_device_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_notifications_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_register_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_schedule_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/presentation/login/ui/login_screen.dart';
import 'package:fakeslink/app/presentation/main_screen/main_screen.dart';
import 'package:fakeslink/app/presentation/notifications/notification_details.dart';
import 'package:fakeslink/app/presentation/results/widget/result_screen.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'app/domain/entities/session.dart';
import 'core/const/app_routes.dart';
import 'core/utils/interceptor.dart';
import 'core/utils/share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  Directory? appDocDir = await getExternalStorageDirectory();
  String appDocPath = appDocDir?.path??"";
  Hive..init(appDocPath)
  ..registerAdapter(StudentAdapter())
  ..registerAdapter(ScheduleAdapter())
  ..registerAdapter(RegisterableClassAdapter())
  ..registerAdapter(SubjectAdapter())
  ..registerAdapter(AdministrativeClassAdapter())
  ..registerAdapter(LecturerAdapter());
  await init();
  runApp(MyApp());
}

Future<void> init() async {
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(() => Semester(
    semesterId: "20211",
    startAt: DateTime(2021, 08, 23), 
    endAt: DateTime(2021,12,31), 
    weeks: 20)
  );
  getIt.registerLazySingleton(()=>GlobalKey<NavigatorState>());
  await DeviceInfo.init();
  await NetworkInfo.init();
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
  getIt.registerLazySingleton<StudentRepository>(() => StudentRepositoryImpl(getIt(),getIt()));
  getIt.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ScheduleRepository>(() => ScheduleRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(getIt(), getIt()));

  /// sources
  getIt.registerLazySingleton(() => AuthenticationRemoteSource());
  getIt.registerLazySingleton(() => StudentRemoteSouce());
  getIt.registerLazySingleton(() => StudentLocalSource());
  getIt.registerLazySingleton(() => NotificationRemoteSource());
  getIt.registerLazySingleton(() => ScheduleRemoteSource());
  getIt.registerLazySingleton(() => ScheduleLocalSource());
  getIt.registerLazySingleton(() => RegisterLocalSource());
  getIt.registerLazySingleton(() => RegisterRemoteSource());

  /// use cases
  getIt.registerLazySingleton(() => LogInUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateNotificationDeviceUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => GetListScheduleUseCase(getIt()));
  getIt.registerLazySingleton(() => GetListNotificationsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetListRegisterUseCase(getIt()));
  
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const oneSignalAppId = "1537dc7c-b315-4c3a-a355-9ca677c33fef";
  void initState() {
    super.initState();
    initOneSignal();
  }

  Future<void> initOneSignal() async {
    await OneSignal.shared.setAppId(oneSignalAppId);
    final state = await OneSignal.shared.getDeviceState();
    if(state?.userId != null) {
      GetIt.instance.registerSingleton<OneSignalId>(OneSignalId(state!.userId!));
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
    GetIt.instance<StreamController<String>>().close();
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
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: GetIt.instance.isRegistered<Session>() ? AppRoute.main : AppRoute.login,
        navigatorKey: GetIt.instance<GlobalKey<NavigatorState>>(),
        routes: {
          AppRoute.login: (context) => Login(),
          AppRoute.main: (context) => MainScreen(),
          AppRoute.notificationDetails: (context) => NotificationDetails(),
          AppRoute.result: (context) => ResultScreen(),
        },
      ),
    );
  }
}