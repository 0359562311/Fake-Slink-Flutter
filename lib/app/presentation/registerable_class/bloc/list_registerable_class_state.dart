import 'package:fakeslink/app/domain/entities/register.dart';

abstract class ListRegisterableClassState {
  const ListRegisterableClassState();
}

class ListRegisterableClassLoadingState extends ListRegisterableClassState {
  const ListRegisterableClassLoadingState();
}

class ListRegisterableClassErrorState extends ListRegisterableClassState {
  final String message;
  const ListRegisterableClassErrorState(this.message);
}

class ListRegisterableClassSuccessfulState extends ListRegisterableClassState {
  final List<Register> registers;
  const ListRegisterableClassSuccessfulState(this.registers);
}