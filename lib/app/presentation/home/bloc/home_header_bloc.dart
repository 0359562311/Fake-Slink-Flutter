import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/entities/user.dart';
import 'package:fakeslink/app/domain/use_cases/get_gpa_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeHeaderBloc extends Bloc<HomeHeaderEvent,HomeHeaderState> {

  late GetProfileUseCase _getProfileUseCase;
  late GetGPAUseCase _getGPAUseCase;

  CustomUser? user;
  GPA? gpa;

  HomeHeaderBloc() : super(HomeHeaderState.init) {
    _getProfileUseCase = GetIt.instance<GetProfileUseCase>();
    _getGPAUseCase = GetIt.instance<GetGPAUseCase>();
  }

  @override
  Stream<HomeHeaderState> mapEventToState(HomeHeaderEvent event) async* {
    try {
      user = await _getProfileUseCase.execute();
      gpa = await _getGPAUseCase.execute();
      yield HomeHeaderState.successful;
    } on Exception catch (e) {
      print(e);
    }
  }
}

enum HomeHeaderEvent {
  init
}

enum HomeHeaderState {
  successful, fail, init
}

