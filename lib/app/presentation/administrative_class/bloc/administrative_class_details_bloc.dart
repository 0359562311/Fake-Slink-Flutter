import 'dart:async';

import 'package:fakeslink/app/domain/use_cases/get_administrative_class_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'administrative_class_details_event.dart';
import 'administrative_class_details_state.dart';

class AdministrativeClassDetailsBloc extends Bloc<
    AdministrativeClassDetailsEvent, AdministrativeClassDetailsState> {
  late final GetAdministrativeClassDetailsUseCase
      _getAdministrativeClassDetails;
  AdministrativeClassDetailsBloc(this._getAdministrativeClassDetails)
      : super(AdministrativeClassDetailsLoadingState()) {
    on<AdministrativeClassDetailsInitEvent>(_onInit);
  }

  FutureOr<void> _onInit(AdministrativeClassDetailsInitEvent event,
      Emitter<AdministrativeClassDetailsState> emit) async {
    final res = await _getAdministrativeClassDetails.execute();
    if (res.isError()) {
      emit(AdministrativeClassDetailsErrorState("Đã có lỗi xảy ra"));
    }
    if (res.isSuccess()) {
      emit(AdministrativeClassDetailsSuccessState(res.getSuccess()!));
    }
  }
}
