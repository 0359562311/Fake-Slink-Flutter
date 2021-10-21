import 'package:fakeslink/app/domain/use_cases/get_registerable_class_details_use_case.dart';
import 'package:fakeslink/app/presentation/registerable_class_details/bloc/registerable_class_details_event.dart';
import 'package:fakeslink/app/presentation/registerable_class_details/bloc/registerable_class_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterableClassDetailsBloc
    extends Bloc<RegisterableClassDetailsEvent, RegisterableClassDetailsState> {
  final GetRegisterableClassDetailsUseCase _getRegisterableClassDetailsUseCase;
  RegisterableClassDetailsBloc(this._getRegisterableClassDetailsUseCase)
      : super(RegisterableClassDetailsLoadingState());

  @override
  Stream<RegisterableClassDetailsState> mapEventToState(
      RegisterableClassDetailsEvent event) async* {
    if (event is RegisterableClassDetailsInitEvent) {
      final res = await _getRegisterableClassDetailsUseCase.execute(event.id);
      if (res.isError()) {
        yield RegisterableClassDetailsErrorState("Đã có lỗi xảy ra!");
      } else {
        yield RegisterableClassDetailsSuccessfulState(res.getSuccess()!);
      }
    }
  }
}
