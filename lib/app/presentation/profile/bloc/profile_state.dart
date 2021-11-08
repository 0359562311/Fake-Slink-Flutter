abstract class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message);
}

class ProfileSuccessState extends ProfileState {
  late final String? message;
  ProfileSuccessState({this.message});
}
