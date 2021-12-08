import 'dart:io';

abstract class EditProfileEvent {
  const EditProfileEvent();
}

class EditAvatarEvent extends EditProfileEvent {
  final File file;
  const EditAvatarEvent(this.file);
}

class EditProfileIn4Event extends EditProfileEvent {
  final String phoneNumber;
  const EditProfileIn4Event(this.phoneNumber);
}