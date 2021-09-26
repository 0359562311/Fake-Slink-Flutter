import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';

class GetListRegisterUseCase {
  final RegisterRepository _repository;
  const GetListRegisterUseCase(this._repository);
  Future<Pair<String,List<Register>>> execute() => _repository.getListRegister();
}