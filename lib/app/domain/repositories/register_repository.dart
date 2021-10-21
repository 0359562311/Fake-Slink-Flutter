import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class RegisterRepository {
  Future<Result<Failure, List<Register>>> getListRegister();
  Future<Result<Failure, RegisterableClass>> getDetails(
      int registerableClassId);
}
