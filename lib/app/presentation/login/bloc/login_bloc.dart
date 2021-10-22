import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_event.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_state.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LogInUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginInitState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithUsernameEvent) {
      yield LoginLoadingState();
      var result = await _loginUseCase.execute(event.username, event.password);
      if (result.isSuccess()) {
        if (GetIt.instance.isRegistered<Session>())
          await GetIt.instance.unregister<Session>();
        GetIt.instance.registerSingleton<Session>(result.getSuccess()!);
        yield LoginSuccessfulState();
      } else {
        final failure = result.getError()!;
        if (failure is APIFailure)
          yield LoginFailState(failure.message);
        else if (failure is NetworkFailure)
          yield LoginFailState("Kiểm tra lại kết nối Internet");
      }
    }
  }
}
