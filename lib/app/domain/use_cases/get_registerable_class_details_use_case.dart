import 'package:fakeslink/app/domain/entities/registerable_class_details.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';

class GetRegisterableClassDetailsUseCase {
  final RegisterRepository _repository;
  const GetRegisterableClassDetailsUseCase(this._repository);

  Future<RegisterableClassDetails> execute(int id) => _repository.getDetails(id);
}