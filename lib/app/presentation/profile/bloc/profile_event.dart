abstract class ProfileEvent {}

class ProfileInitEvent extends ProfileEvent {}

class ProfileLogoutEvent extends ProfileEvent {}

class ProfileSetUpFingerprintEvent extends ProfileEvent {
  final String password;
  ProfileSetUpFingerprintEvent(this.password);
}
