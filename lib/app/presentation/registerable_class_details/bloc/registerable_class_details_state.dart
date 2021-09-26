import 'package:fakeslink/app/domain/entities/registerable_class.dart';

abstract class RegisterableClassDetailsState {}

class RegisterableClassDetailsLoadingState extends RegisterableClassDetailsState {}

class RegisterableClassDetailsErrorState extends RegisterableClassDetailsState {
  final String message;
  RegisterableClassDetailsErrorState(this.message);
}

class RegisterableClassDetailsSuccessfulState extends RegisterableClassDetailsState {
  final RegisterableClass registerableClass;
  RegisterableClassDetailsSuccessfulState(this.registerableClass);
}