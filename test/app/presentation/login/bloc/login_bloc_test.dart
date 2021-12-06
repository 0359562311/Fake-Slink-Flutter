import 'package:bloc_test/bloc_test.dart';
import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_bloc.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_event.dart';
import 'package:fakeslink/app/presentation/login/bloc/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../main_test.dart';
import '../../../domain/use_cases/generate_mock_use_cases.mocks.dart';

void main() {
  late final MockLogInUseCase logInUseCase;
  late final MockLogInWithFingeprintUseCase logInWithFingeprintUseCase;
  late final LoginBloc loginBloc;
  setUpAll(() {
    registerDependencies();
    logInUseCase = MockLogInUseCase();
    logInWithFingeprintUseCase = MockLogInWithFingeprintUseCase();
    loginBloc = LoginBloc(logInUseCase, logInWithFingeprintUseCase);
  });
  tearDownAll(() => unregisterDependencies());
  blocTest<LoginBloc, LoginState>(
      'emit when login with username and password successful',
      build: () {
        when(logInUseCase.execute(any, any)).thenAnswer(
            (realInvocation) async =>
                Success(Session(access: "access", refresh: "refresh")));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginWithUsernameEvent("username", "password")),
      expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessfulState>()],
      verify: (_) {
        verify(logInUseCase.execute(any, any));
      });
}
