abstract class LoginEvent {}

class LoginWithUsernameEvent extends LoginEvent {
  final String username;
  final String password;

  LoginWithUsernameEvent(this.username, this.password);
}