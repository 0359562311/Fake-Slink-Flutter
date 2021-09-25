import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_register_usecase.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_event.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final GetListRegisterUseCase _getListRegisterUseCase =
      GetIt.instance<GetListRegisterUseCase>();
  ResultBloc() : super(ResultLoadingState());

  List<Register> _registers = [];
  List<Register> get register => _registers;

  @override
  Stream<ResultState> mapEventToState(ResultEvent event) async* {
    if (event is ResultInitEvent) {
      yield ResultLoadingState();
      final res = await _getListRegisterUseCase.execute();
      if (res.result != null) {
        _registers = res.result!;
        yield ResultSuccessfulState();
      }
      if (res.error != null) {
        yield ResultErrorState(res.error!);
      }
    }
  }
}
