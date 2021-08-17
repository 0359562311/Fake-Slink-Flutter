abstract class LoginState {}

class LoginLoadingState extends LoginState{}

class LoginInitState extends LoginState{}

class LoginFailState extends LoginState{
  final String message;

  LoginFailState(this.message);
}

class LoginSuccessfulState extends LoginState {}