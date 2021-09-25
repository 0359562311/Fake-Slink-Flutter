import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/entities/registerable_class_details.dart';

abstract class RegisterRepository {
  Future<Pair<String,List<Register>>> getListRegister();
  Future<RegisterableClassDetails> getDetails(int registerableClassId);
}