import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/data/repositories/administrative_class_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/authentication_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/notification_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/register_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/schedule_repository_impl.dart';
import 'package:fakeslink/app/data/repositories/student_repository_impl.dart';
import 'package:fakeslink/app/data/sources/administrative_class_sources.dart';
import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/app/data/sources/notification_sources.dart';
import 'package:fakeslink/app/data/sources/register_source.dart';
import 'package:fakeslink/app/data/sources/schedule_sources.dart';
import 'package:fakeslink/app/data/sources/student_sources.dart';
import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/repositories/administrative_class_repository.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';
import 'package:fakeslink/app/domain/use_cases/create_notification_device_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_administrative_class_details.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_notifications_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_register_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_schedule_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_registerable_class_details_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/login_with_fingerprint_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/set_up_fingerprint_auth_use_case.dart';
import 'package:fakeslink/app/presentation/administrative_class/administrative_screen.dart';
import 'package:fakeslink/app/presentation/list_schedules/widget/list_schedules.dart';
import 'package:fakeslink/app/presentation/login/ui/login_screen.dart';
import 'package:fakeslink/app/presentation/main_screen/main_screen.dart';
import 'package:fakeslink/app/presentation/notifications/ui/notification_details.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_bloc.dart';
import 'package:fakeslink/app/presentation/results/widget/result_screen.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'app/data/model/administrative_class_details_model.dart';
import 'app/data/model/administrative_class_model.dart';
import 'app/data/model/lecturer_model.dart';
import 'app/data/model/register_model.dart';
import 'app/data/model/registerable_class_model.dart';
import 'app/data/model/schedule_model.dart';
import 'app/data/model/subject_model.dart';
import 'app/domain/entities/session.dart';
import 'app/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'app/presentation/administrative_class/bloc/administrative_class_details_bloc.dart';
import 'app/presentation/home/bloc/home_notifications_bloc.dart';
import 'app/presentation/list_registerable_class/bloc/list_registerable_class_bloc.dart';
import 'app/presentation/list_registerable_class/ui/list_registerable_class_screen.dart';
import 'app/presentation/list_schedules/bloc/list_schedules_bloc.dart';
import 'app/presentation/login/bloc/login_bloc.dart';
import 'app/presentation/notifications/bloc/notification_bloc.dart';
import 'app/presentation/registerable_class_details/bloc/registerable_class_details_bloc.dart';
import 'app/presentation/registerable_class_details/ui/registerable_class_details_screen.dart';
import 'app/presentation/results/bloc/result_bloc.dart';
import 'core/const/app_routes.dart';
import 'core/utils/interceptor.dart';
import 'core/utils/share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  Directory? appDocDir = await getExternalStorageDirectory();
  String appDocPath = appDocDir?.path ?? "";
  Hive
    ..init(appDocPath)
    ..registerAdapter(StudentModelAdapter())
    ..registerAdapter(ScheduleModelAdapter())
    ..registerAdapter(RegisterableClassModelAdapter())
    ..registerAdapter(SubjectModelAdapter())
    ..registerAdapter(AdministrativeClassModelAdapter())
    ..registerAdapter(AdministrativeClassDetailsModelAdapter())
    ..registerAdapter(RegisterModelAdapter())
    ..registerAdapter(NotificationAdapter())
    ..registerAdapter(NotificationDetailsAdapter())
    ..registerAdapter(SenderAdapter())
    ..registerAdapter(LecturerModelAdapter());
  await init();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

Future<void> init() async {
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(() => Semester(
      semesterId: "20211",
      startAt: DateTime(2021, 08, 23),
      endAt: DateTime(2021, 12, 31),
      weeks: 20));
  getIt.registerLazySingleton(() => GlobalKey<NavigatorState>());

  final deviceInfo = DeviceInfo();
  await deviceInfo.init();
  getIt.registerSingleton(deviceInfo);

  final networkInfo = NetworkInfo();
  await networkInfo.init();
  getIt.registerSingleton(networkInfo);

  final spUtils = SharePreferencesUtils();
  await spUtils.init();
  getIt.registerFactory(() => spUtils);
  if (spUtils.getString("refresh") != null) {
    getIt.registerSingleton(Session(
        access: spUtils.getString("access")!,
        refresh: spUtils.getString("refresh")!));
  }
  getIt.registerLazySingleton(() => Hive);

  var options = BaseOptions(
      baseUrl: 'http://192.168.0.101:8000',
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.json);

  getIt.registerSingleton(Dio(options)
    ..interceptors.addAll([
      AuthenticationInterceptor(),
      LogInterceptor(
          requestBody: true,
          requestHeader: false,
          responseBody: true,
          request: false,
          responseHeader: false,
          error: true),
    ]));

  /// repositories
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<StudentRepository>(
      () => StudentRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ScheduleRepository>(
      () => ScheduleRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<AdministrativeClassRepository>(
      () => AdministrativeClassReporitoryImpl(getIt(), getIt()));

  /// sources
  getIt.registerLazySingleton(() => AuthenticationRemoteSource());
  getIt.registerLazySingleton(() => AuthenticationLocalSource());
  getIt.registerLazySingleton(() => StudentRemoteSouce());
  getIt.registerLazySingleton(() => StudentLocalSource());
  getIt.registerLazySingleton(() => NotificationRemoteSource());
  getIt.registerLazySingleton(() => NotificationLocalSource());
  getIt.registerLazySingleton(() => ScheduleRemoteSource());
  getIt.registerLazySingleton(() => ScheduleLocalSource());
  getIt.registerLazySingleton(() => RegisterLocalSource());
  getIt.registerLazySingleton(() => RegisterRemoteSource());
  getIt.registerLazySingleton(() => AdministrativeClassRemoteSource());
  getIt.registerLazySingleton(() => AdministrativeClassLocalSource());

  /// use cases
  getIt.registerLazySingleton(() => LogInUseCase(getIt()));
  getIt.registerLazySingleton(() => LogInWithFingeprintUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateNotificationDeviceUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => SetUpFingerPrintAuthUseCase(getIt()));
  getIt.registerLazySingleton(() => GetListScheduleUseCase(getIt()));
  getIt.registerLazySingleton(() => GetListNotificationsUseCase(getIt()));
  getIt.registerLazySingleton(() => MarkNotificationAsReadUseCase(getIt()));
  getIt.registerLazySingleton(() => GetListRegisterUseCase(getIt()));
  getIt
      .registerLazySingleton(() => GetRegisterableClassDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAdministrativeClassDetails(getIt()));

  /// bloc
  getIt.registerFactory(() => ListRegisterableClassBloc(getIt()));
  getIt.registerFactory(() => AdministrativeClassDetailsBloc(getIt()));
  getIt.registerFactory(() => HomeNotificationsBloc(getIt(), getIt()));
  getIt.registerFactory(() => ListScheduleBloc(getIt()));
  getIt.registerFactory(() => LoginBloc(getIt(), getIt()));
  getIt.registerFactory(() => NotificationBloc(getIt(), getIt()));
  getIt.registerFactory(() => ResultBloc(getIt()));
  getIt.registerFactory(() => RegisterableClassDetailsBloc(getIt()));
  getIt.registerFactory(() => ProfileBloc(getIt(), getIt()));
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
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      var data = openedResult.notification.additionalData;
      GetIt.instance<GlobalKey<NavigatorState>>()
          .currentState
          ?.pushNamed(AppRoute.notificationDetails, arguments: data);
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
    });
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      print(
          "TanKiem: setPermissionObserver from ${changes.from.status} to ${changes.to.status}");
    });
    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
      print(
          "TanKiem: setSubscriptionObserver from ${changes.from.pushToken} to ${changes.to.pushToken}");
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
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: GetIt.instance.isRegistered<Session>()
            ? AppRoute.main
            : AppRoute.login,
        navigatorKey: GetIt.instance<GlobalKey<NavigatorState>>(),
        routes: {
          AppRoute.login: (context) => Login(),
          AppRoute.main: (context) => MainScreen(),
          AppRoute.notificationDetails: (context) =>
              NotificationDetailsScreen(),
          AppRoute.result: (context) => ResultScreen(),
          AppRoute.listSchedules: (context) => ListSchedule(),
          AppRoute.administrativeClass: (context) =>
              AdministrativeClassScreen(),
          AppRoute.listRegisterableClass: (context) =>
              ListRegisterableClassScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == AppRoute.registerableClassDetails) {
            return MaterialPageRoute(
                builder: (context) => RegisterableClassDetailsScreen(
                      id: settings.arguments as int,
                    ));
          }
        },
      ),
    );
  }
}
