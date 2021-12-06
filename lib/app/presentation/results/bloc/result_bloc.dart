import 'dart:async';

import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_register_usecase.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_event.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final GetListRegisterUseCase _getListRegisterUseCase;
  ResultBloc(this._getListRegisterUseCase) : super(ResultLoadingState()) {
    on<ResultInitEvent>(_onInit);
  }

  List<Register> _registers = [];
  List<Register> get register => _registers;

  FutureOr<void> _onInit(
      ResultInitEvent event, Emitter<ResultState> emit) async {
    emit(ResultLoadingState());
    final res = await _getListRegisterUseCase.execute();
    if (res.isSuccess()) {
      _registers = res.getSuccess()!;
      emit(ResultSuccessfulState());
    } else {
      emit(ResultErrorState("Đã có lỗi xảy ra"));
    }
  }
}
