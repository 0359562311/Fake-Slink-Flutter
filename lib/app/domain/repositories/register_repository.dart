import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';

abstract class RegisterRepository {
  Future<Pair<String,List<Register>>> getListRegister();
  Future<Pair<String,RegisterableClass>> getDetails(int registerableClassId);
}