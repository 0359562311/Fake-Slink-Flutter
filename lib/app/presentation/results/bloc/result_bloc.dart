import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_register_usecase.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_event.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final GetListRegisterUseCase _getListRegisterUseCase = GetIt.instance<GetListRegisterUseCase>();
  ResultBloc() : super(ResultLoadingState());

  List<Register> _registers = [];
  List<Register> get register => _registers;

  @override
  Stream<ResultState> mapEventToState(ResultEvent event) async* {
    try {
      if(event is ResultInitEvent) {
        yield ResultLoadingState();
        _registers = await _getListRegisterUseCase.execute();
        yield ResultSuccessfulState();
      }
    } on DioError {
      yield ResultErrorState("Đã có lỗi xảy ra");
    }
  }

}