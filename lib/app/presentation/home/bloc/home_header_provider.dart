import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:fakeslink/core/architecture/failure.dart';
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
    final res = await _getProfileUseCase.execute();
    _user = res.getSuccess();
    if (_user != null) {
      if (GetIt.instance.isRegistered<Student>())
        GetIt.instance.unregister<Student>();
      GetIt.instance.registerLazySingleton<Student>(() => _user!);
    } else {
      final e = res.getError()!;
      if (e is APIFailure && e.message == "Phiên đăng nhập đã hết.") {}
    }
    notifyListeners();
  }
}
