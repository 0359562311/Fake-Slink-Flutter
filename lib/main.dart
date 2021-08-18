import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/repositories/authentication_repository_impl.dart';
import 'package:fakeslink/app/data/sources/authentication_sources.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/presentation/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
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
      baseUrl: 'http://192.168.0.100:8000',
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

  /// sources
  getIt.registerLazySingleton(() => AuthenticationRemoteSource());

  /// use cases
  getIt.registerLazySingleton(() => LogInUseCase(getIt()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final subscription;
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      NetworkInfo.isConnecting = result != ConnectivityResult.none;
    });
  }

  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: GetIt.instance.isRegistered<Session>() ? AppRoute.main : AppRoute.login,
      routes: {
        AppRoute.login: (context) => Login(),
        AppRoute.main: (context) => Container()
      },
    );
  }
}
