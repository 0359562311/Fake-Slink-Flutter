import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/session_model.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:get_it/get_it.dart';

class AuthenticationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    if (GetIt.instance.isRegistered<Session>()) {
      options.headers['Authorization'] =
      "Bearer ${GetIt.instance<Session>().access}";
    }
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError
    // TODO: implement onError
    if (err.response?.requestOptions.path.startsWith("/auth") ?? true) {
      handler.next(err);
    } else if (err.response?.statusCode == 401
    ) {
      var dio = GetIt.instance<Dio>();
      dio.interceptors.requestLock.lock();
      RequestOptions options = err.requestOptions;
      await Dio()
          .post(options.baseUrl + "/auth/jwt/refresh/",
          data: {"refresh": GetIt.instance<Session>().refresh},
          options: Options(headers: {
            'Authorization': "Bearer ${GetIt.instance<Session>().access}"
          }))
      .then((value) async {
            dio.interceptors.requestLock.unlock();
            if(GetIt.instance.isRegistered<Session>())
              GetIt.instance.unregister<Session>();
            GetIt.instance.registerSingleton<Session>(SessionModel.fromResponse(value));
            var queryParams = options.queryParameters;
            var data = options.data;
            await Dio()
                .request(options.baseUrl + options.path,
                queryParameters: queryParams,
                data: data,
                options: Options(headers: {
                  'Authorization': "Bearer ${GetIt.instance<Session>().access}"
                }, method: options.method))
                .then((value) {
                  print("value from interceptor $value");
                  handler.resolve(value..data = value.data['data']);
                }).catchError((error) {
                  handler.reject(error);
                });
      }).catchError((error) {
        print("Refresh token expired");
        dio.clear();
        GetIt.instance<StreamController<bool>>().add(false);
      });
    } else
      handler.reject(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    handler.next(response..data = response.data['data']);
  }
}
