import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';

abstract class AdministrativeClassRepository {
  Future<AdministrativeClassDetails> getDetails();
}