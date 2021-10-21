import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdministrativeClassRepository {
  Future<Result<Failure, AdministrativeClassDetails>> getDetails();
}
