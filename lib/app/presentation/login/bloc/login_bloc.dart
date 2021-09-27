import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_event.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_state.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LogInUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginInitState());

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
