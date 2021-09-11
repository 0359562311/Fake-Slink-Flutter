import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';

class GetListRegisterUseCase {
  final RegisterRepository repository;
  const GetListRegisterUseCase(this.repository);

  Future<List<Register>> execute() => repository.getListRegister();
}