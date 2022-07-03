import 'dart:async';

import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/login_with_fingerprint_use_case.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_event.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_state.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LogInUseCase _loginUseCase;
  final LogInWithFingeprintUseCase _fingeprintUseCase;

  LoginBloc(this._loginUseCase, this._fingeprintUseCase)
      : super(LoginInitState()) {
    on<LoginWithUsernameEvent>(_onLoginUsername);
    on<LoginWithFingerprintEvent>(_onLoginByfingerprint);
  }

  FutureOr<void> _onLoginUsername(
      LoginWithUsernameEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    Result result = await _loginUseCase.execute(event.username, event.password);
    return await _handleResult(emit, result);
  }

  FutureOr<void> _onLoginByfingerprint(
      LoginWithFingerprintEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    Result result = await _fingeprintUseCase.execute();
    return await _handleResult(emit, result);
  }

  Future _handleResult(Emitter<LoginState> emit, Result result) async {
    if (result.isSuccess()) {
      if (GetIt.instance.isRegistered<Session>())
        await GetIt.instance.unregister<Session>();
      GetIt.instance.registerSingleton<Session>(result.getSuccess()!);
      emit(LoginSuccessfulState());
    } else {
      final failure = result.getError()!;
      if (failure is APIFailure)
        emit(LoginFailState(failure.message));
      else if (failure is NetworkFailure)
        emit(LoginFailState("Kiểm tra lại kết nối Internet"));
      else if (failure is PlatformFailure)
        emit(LoginFailState(failure.message));
    }
  }
}
