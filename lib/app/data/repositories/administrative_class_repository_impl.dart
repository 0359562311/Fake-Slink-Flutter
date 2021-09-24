import 'package:fakeslink/app/data/sources/administrative_class_sources.dart';
import 'package:fakeslink/app/domain/entities/administrative_detail.dart';
import 'package:fakeslink/app/domain/repositories/administrative_class_repository.dart';

class AdministrativeClassReporitoryImpl extends AdministrativeClassRepository {
  final AdministrativeClassRemoteSource _remoteSource;

  AdministrativeClassReporitoryImpl(this._remoteSource);

  @override
  Future<AdministrativeClassDetails> getDetails() {
    return _remoteSource.getDetails();
  }
}