import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HomeHeaderProvider extends ChangeNotifier {
  late GetProfileUseCase _getProfileUseCase;

  Student? _user;

  Student? get user => _user;

  HomeHeaderProvider() {
    _getProfileUseCase = GetIt.instance<GetProfileUseCase>();
    init();
  }

  Future<void> init() async {
    _user = await _getProfileUseCase.execute();
    if(_user != null)
      GetIt.instance.resetLazySingleton<Student>(instance: _user!);
    notifyListeners();
  }
}
