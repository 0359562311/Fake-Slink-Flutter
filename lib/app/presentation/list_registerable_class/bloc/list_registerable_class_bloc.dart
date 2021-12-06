import 'dart:async';

import 'package:fakeslink/app/domain/use_cases/get_list_register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_registerable_class_event.dart';
import 'list_registerable_class_state.dart';

class ListRegisterableClassBloc
    extends Bloc<ListRegisterableClassEvent, ListRegisterableClassState> {
  final GetListRegisterUseCase _getListRegisterUseCase;
  ListRegisterableClassBloc(this._getListRegisterUseCase)
      : super(ListRegisterableClassLoadingState()) {
    on<ListRegisterableClassInitEvent>(_onInit);
  }

  FutureOr<void> _onInit(ListRegisterableClassInitEvent event,
      Emitter<ListRegisterableClassState> emit) async {
    final res = await _getListRegisterUseCase.execute();
    if (res.isError()) {
      emit(ListRegisterableClassErrorState("Đã có lỗi xảy ra!"));
    } else {
      emit(ListRegisterableClassSuccessfulState(res.getSuccess()!));
    }
  }
}
