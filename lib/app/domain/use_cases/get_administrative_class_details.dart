import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';
import 'package:fakeslink/app/domain/entities/pair.dart';
import 'package:fakeslink/app/domain/repositories/administrative_class_repository.dart';

class GetAdministrativeClassDetails {
  final AdministrativeClassRepository _repository;

  const GetAdministrativeClassDetails(this._repository);

  Future<Pair<String,AdministrativeClassDetails>> execute() => _repository.getDetails();
}