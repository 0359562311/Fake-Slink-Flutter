import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_event.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_state.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late LogInUseCase _useCase;
  LoginBloc() : super(LoginInitState()) {
    _useCase = GetIt.instance<LogInUseCase>();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is LoginWithUsernameEvent) {
        yield LoginLoadingState();
        var session = await _useCase.execute(event.username, event.password);
        if(GetIt.instance.isRegistered<Session>())
          await GetIt.instance.unregister<Session>();
        GetIt.instance.registerSingleton(session);
        SharePreferencesUtils.setString("access", session.access);
        SharePreferencesUtils.setString("refresh", session.refresh);
        yield LoginSuccessfulState();
      }
    } on DioError catch (e) {
      yield LoginFailState(e.response?.data['data']['detail']??"Đã có lỗi xảy ra.");
    }
  }

}