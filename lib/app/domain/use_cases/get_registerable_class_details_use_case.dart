import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class GetRegisterableClassDetailsUseCase {
  final RegisterRepository _repository;
  const GetRegisterableClassDetailsUseCase(this._repository);

  Future<Result<Failure, RegisterableClass>> execute(int id) =>
      _repository.getDetails(id);
}
