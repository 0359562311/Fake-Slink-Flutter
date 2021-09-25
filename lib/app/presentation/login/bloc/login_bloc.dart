import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_event.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_state.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final LogInUseCase _loginUseCase;

  LoginBloc() : super(LoginInitState()) {
    _loginUseCase = GetIt.instance<LogInUseCase>();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (NetworkInfo.isConnecting) {
      try {
        if (event is LoginWithUsernameEvent) {
          yield LoginLoadingState();
          var session =
              await _loginUseCase.execute(event.username, event.password);
          if (GetIt.instance.isRegistered<Session>())
            await GetIt.instance.unregister<Session>();
          GetIt.instance.registerSingleton<Session>(session);
          SharePreferencesUtils.setString("access", session.access);
          SharePreferencesUtils.setString("refresh", session.refresh);
          yield LoginSuccessfulState();
        }
      } on DioError catch (e) {
        if (e.requestOptions.path.contains(APIPath.logIn))
          yield LoginFailState("Tên đăng nhập hoặc mật khẩu không chính xác");
      }
    } else {
      yield LoginFailState("Kiểm tra lại kết nối Internet");
    }
  }
}
