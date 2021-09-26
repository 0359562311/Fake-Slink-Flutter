import 'package:fakeslink/app/domain/use_cases/get_administrative_class_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'administrative_class_details_event.dart';
import 'administrative_class_details_state.dart';

class AdministrativeClassDetailsBloc extends Bloc<
    AdministrativeClassDetailsEvent, AdministrativeClassDetailsState> {
  late final GetAdministrativeClassDetails _getAdministrativeClassDetails;
  AdministrativeClassDetailsBloc(this._getAdministrativeClassDetails)
      : super(AdministrativeClassDetailsLoadingState());

  @override
  Stream<AdministrativeClassDetailsState> mapEventToState(
      AdministrativeClassDetailsEvent event) async* {
    if (event is AdministrativeClassDetailsInitEvent) {
      final res = await _getAdministrativeClassDetails.execute();
      if (res.error != null) {
        yield AdministrativeClassDetailsErrorState(res.error!);
      }
      if (res.result != null) {
        yield AdministrativeClassDetailsSuccessState(res.result!);
      }
    }
  }
}
