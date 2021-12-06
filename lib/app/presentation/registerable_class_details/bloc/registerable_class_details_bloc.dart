import 'dart:async';

import 'package:fakeslink/app/domain/use_cases/get_registerable_class_details_use_case.dart';
import 'package:fakeslink/app/presentation/registerable_class_details/bloc/registerable_class_details_event.dart';
import 'package:fakeslink/app/presentation/registerable_class_details/bloc/registerable_class_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterableClassDetailsBloc
    extends Bloc<RegisterableClassDetailsEvent, RegisterableClassDetailsState> {
  final GetRegisterableClassDetailsUseCase _getRegisterableClassDetailsUseCase;
  RegisterableClassDetailsBloc(this._getRegisterableClassDetailsUseCase)
      : super(RegisterableClassDetailsLoadingState()) {
    on<RegisterableClassDetailsInitEvent>(_onInit);
  }

  FutureOr<void> _onInit(RegisterableClassDetailsInitEvent event,
      Emitter<RegisterableClassDetailsState> emit) async {
    final res = await _getRegisterableClassDetailsUseCase.execute(event.id);
    if (res.isError()) {
      emit(RegisterableClassDetailsErrorState("Đã có lỗi xảy ra!"));
    } else {
      emit(RegisterableClassDetailsSuccessfulState(res.getSuccess()!));
    }
  }
}
