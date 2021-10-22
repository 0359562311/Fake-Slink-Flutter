import 'package:fakeslink/app/data/repositories/student_repository_impl.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_event.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _usecase;

  ProfileBloc(this._usecase) : super(ProfileLoadingState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileInitEvent) {
      if (GetIt.instance.isRegistered<Student>()) {
        await Future.delayed(Duration(milliseconds: 200));
        yield ProfileSuccessState();
      } else {
        final res = await _usecase.execute();
        if (res.isSuccess())
          yield ProfileSuccessState();
        else
          yield ProfileErrorState();
      }
    }
  }
}
