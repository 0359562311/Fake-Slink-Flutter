import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart';
import 'package:fakeslink/app/domain/entities/pair.dart';

abstract class AdministrativeClassRepository {
  Future<Pair<String,AdministrativeClassDetails>> getDetails();
}