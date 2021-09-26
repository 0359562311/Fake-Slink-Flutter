import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/registerable_class.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';

class GetRegisterableClassDetailsUseCase {
  final RegisterRepository _repository;
  const GetRegisterableClassDetailsUseCase(this._repository);

  Future<Pair<String,RegisterableClass>> execute(int id) => _repository.getDetails(id);
}