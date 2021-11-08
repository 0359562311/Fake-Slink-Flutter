import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/set_up_fingerprint_auth_use_case.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_event.dart';
import 'package:fakeslink/app/presentation/profile/bloc/profile_state.dart';
import 'package:fakeslink/core/utils/share_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _usecase;
  final SetUpFingerPrintAuthUseCase _setUpFingerPrintAuth;

  ProfileBloc(this._usecase, this._setUpFingerPrintAuth)
      : super(ProfileLoadingState());

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
          yield ProfileErrorState(res.getError()!.message);
      }
    } else if (event is ProfileLogoutEvent) {
      GetIt.instance<SharePreferencesUtils>().clearSession();
      Hive.deleteBoxFromDisk("user");
      Hive.deleteBoxFromDisk("schedules");
      Hive.deleteBoxFromDisk("notifications");
      Hive.deleteBoxFromDisk("register");
      Hive.deleteBoxFromDisk("administrativeClassDetails");
    } else if (event is ProfileSetUpFingerprintEvent) {
      yield ProfileLoadingState();
      final res = await _setUpFingerPrintAuth.execute(event.password);
      if (res.isError()) {
        yield ProfileErrorState(res.getError()!.message);
        yield ProfileSuccessState();
      } else {
        yield ProfileSuccessState(message: "Cài đặt thành công");
      }
    }
  }
}
