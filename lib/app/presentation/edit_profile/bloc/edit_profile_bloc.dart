import 'dart:async';

import 'package:fakeslink/app/domain/use_cases/update_avatar_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/update_profile_usecase.dart';
import 'package:fakeslink/app/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:fakeslink/app/presentation/edit_profile/bloc/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateAvatarUseCase _updateAvatarUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  EditProfileBloc(this._updateAvatarUseCase, this._updateProfileUseCase)
      : super(EditProfileInitState()) {
    on<EditAvatarEvent>(_onUpdateAvatarEvent);
    on<EditProfileIn4Event>(_onUpdateIn4Event);
  }

  FutureOr<void> _onUpdateAvatarEvent(
      EditAvatarEvent event, Emitter<EditProfileState> emit) async {
    final res = await _updateAvatarUseCase.execute(event.file);
    if (res.isSuccess()) {
      emit(EditProfileSuccessfulState());
    } else {
      emit(EditProfileErrorState(res.getError()!.message));
    }
  }

  FutureOr<void> _onUpdateIn4Event(
      EditProfileIn4Event event, Emitter<EditProfileState> emit) async {
    final res = await _updateProfileUseCase.execute("", event.phoneNumber);
    if (res.isSuccess()) {
      emit(EditProfileSuccessfulState());
    } else {
      emit(EditProfileErrorState(res.getError()!.message));
    }
  }
}
