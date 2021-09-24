import 'package:fakeslink/app/domain/entities/administrative_detail.dart';

abstract class AdministrativeClassDetailsState {
  const AdministrativeClassDetailsState();
}

class AdministrativeClassDetailsLoadingState extends AdministrativeClassDetailsState {
  const AdministrativeClassDetailsLoadingState();
}

class AdministrativeClassDetailsErrorState extends AdministrativeClassDetailsState {
  final String message;
  const AdministrativeClassDetailsErrorState(this.message);
}

class AdministrativeClassDetailsSuccessState extends AdministrativeClassDetailsState {
  final AdministrativeClassDetails details;
  const AdministrativeClassDetailsSuccessState(this.details);
}