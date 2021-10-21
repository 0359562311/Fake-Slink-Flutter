import 'package:fakeslink/app/domain/use_cases/get_list_register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_registerable_class_event.dart';
import 'list_registerable_class_state.dart';

class ListRegisterableClassBloc
    extends Bloc<ListRegisterableClassEvent, ListRegisterableClassState> {
  final GetListRegisterUseCase _getListRegisterUseCase;
  ListRegisterableClassBloc(this._getListRegisterUseCase)
      : super(ListRegisterableClassLoadingState());

  @override
  Stream<ListRegisterableClassState> mapEventToState(
      ListRegisterableClassEvent event) async* {
    if (event is ListRegisterableClassInitEvent) {
      final res = await _getListRegisterUseCase.execute();
      if (res.isError()) {
        yield ListRegisterableClassErrorState("Đã có lỗi xảy ra!");
      } else {
        yield ListRegisterableClassSuccessfulState(res.getSuccess()!);
      }
    }
  }
}
