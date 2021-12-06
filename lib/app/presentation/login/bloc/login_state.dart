abstract class LoginState {
  const LoginState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginInitState extends LoginState {
  const LoginInitState();
}

class LoginFailState extends LoginState {
  final String message;

  const LoginFailState(this.message);
}

class LoginSuccessfulState extends LoginState {
  const LoginSuccessfulState();
}
