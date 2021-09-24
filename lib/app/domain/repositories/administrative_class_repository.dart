import 'package:fakeslink/app/domain/entities/administrative_detail.dart';

abstract class AdministrativeClassRepository {
  Future<AdministrativeClassDetails> getDetails();
}