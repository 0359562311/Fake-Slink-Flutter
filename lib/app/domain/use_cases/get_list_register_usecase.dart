import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';
import 'package:fakeslink/core/architecture/failure.dart';
import 'package:multiple_result/multiple_result.dart';

class GetListRegisterUseCase {
  final RegisterRepository _repository;
  const GetListRegisterUseCase(this._repository);
  Future<Result<Failure, List<Register>>> execute() =>
      _repository.getListRegister();
}
