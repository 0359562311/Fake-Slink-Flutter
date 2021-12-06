import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';
import 'package:fakeslink/app/domain/repositories/administrative_class_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class GetAdministrativeClassDetailsUseCase {
  final AdministrativeClassRepository _repository;

  const GetAdministrativeClassDetailsUseCase(this._repository);

  Future<Result<Failure, AdministrativeClassDetails>> execute() =>
      _repository.getDetails();
}
