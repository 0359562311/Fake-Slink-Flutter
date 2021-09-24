import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/use_cases/get_administrative_class_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'administrative_class_details_event.dart';
import 'administrative_class_details_state.dart';

class AdministrativeClassDetailsBloc extends Bloc<AdministrativeClassDetailsEvent, AdministrativeClassDetailsState> {
  late final GetAdministrativeClassDetails _getAdministrativeClassDetails;
  AdministrativeClassDetailsBloc() : super(AdministrativeClassDetailsLoadingState()) {
    _getAdministrativeClassDetails = GetIt.instance();
  }

  @override
  Stream<AdministrativeClassDetailsState> mapEventToState(AdministrativeClassDetailsEvent event) async* {
    try {
      if(event is AdministrativeClassDetailsInitEvent) {
        final res = await _getAdministrativeClassDetails.execute();
        yield AdministrativeClassDetailsSuccessState(res);
      }
    } on DioError catch (e) {
      yield AdministrativeClassDetailsErrorState(e.response?.data['detail']??"Đã có lỗi xảy ra");
    }
  }

}