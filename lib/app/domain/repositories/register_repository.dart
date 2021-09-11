import 'package:fakeslink/app/domain/entities/register.dart';

abstract class RegisterRepository {
  Future<List<Register>> getListRegister();
}