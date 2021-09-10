import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/gpa.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/domain/use_cases/get_gpa_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HomeHeaderProvider extends ChangeNotifier {
  late GetProfileUseCase _getProfileUseCase;
  late GetGPAUseCase _getGPAUseCase;

  Student? _user;
  GPA? _gpa;

  Student? get user => _user;
  GPA? get gpa => _gpa;

  HomeHeaderProvider() {
    _getProfileUseCase = GetIt.instance<GetProfileUseCase>();
    _getGPAUseCase = GetIt.instance<GetGPAUseCase>();
    init();
  }

  Future<void> init() async {
    try {
      _user = await _getProfileUseCase.execute();
      _gpa = await _getGPAUseCase.execute();
    } on DioError catch (e) {
    }
    notifyListeners();
  }
}
