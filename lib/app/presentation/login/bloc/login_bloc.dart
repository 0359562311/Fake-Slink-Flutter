import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/use_cases/create_notification_device_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_event.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_state.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late LogInUseCase _loginUseCase;
  late CreateNotificationDeviceUseCase _createNotificationDeviceUseCase;

  LoginBloc() : super(LoginInitState()){
    _loginUseCase = GetIt.instance<LogInUseCase>();
    _createNotificationDeviceUseCase = GetIt.instance<CreateNotificationDeviceUseCase>();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is LoginWithUsernameEvent) {
        yield LoginLoadingState();
        var session = await _loginUseCase.execute(event.username, event.password);
        if(GetIt.instance.isRegistered<Session>())
          await GetIt.instance.unregister<Session>();
        GetIt.instance.registerSingleton(session);
        SharePreferencesUtils.setString("access", session.access);
        SharePreferencesUtils.setString("refresh", session.refresh);
        if(DeviceInfo.deviceId != null)
          _createNotificationDeviceUseCase.execute(DeviceInfo.deviceId!, GetIt.instance<String>());
        yield LoginSuccessfulState();
      }
    } on DioError catch (e) {
      if(e.requestOptions.path.contains(APIPath.logIn))
        yield LoginFailState("Tên đăng nhập hoặc mật khẩu không chính xác");
    }
  }

}