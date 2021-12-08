abstract class EditProfileState {
  const EditProfileState();
}

class EditProfileErrorState extends EditProfileState {
  final String message;
  const EditProfileErrorState(this.message);
}

class EditProfileSuccessfulState extends EditProfileState {
  const EditProfileSuccessfulState();
}

class EditProfileLoadingState extends EditProfileState {
  const EditProfileLoadingState();
}

class EditProfileInitState extends EditProfileState {
  const EditProfileInitState();
}