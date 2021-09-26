abstract class RegisterableClassDetailsEvent {}

class RegisterableClassDetailsInitEvent extends RegisterableClassDetailsEvent{
  final int id;
  RegisterableClassDetailsInitEvent(this.id);
}