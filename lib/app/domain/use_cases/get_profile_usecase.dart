import 'package:fakeslink/app/domain/entities/user.dart';
import 'package:fakeslink/app/domain/repositories/user_repository.dart';

class GetProfileUseCase {
  final UserRepository repository;
  GetProfileUseCase(this.repository);

  Future<CustomUser> execute()
    => repository.getProfile();
}