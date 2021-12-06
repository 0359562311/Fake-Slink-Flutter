import 'package:fakeslink/app/domain/entities/session.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';

import '../repositories/generate_mock_repositories_test.mocks.dart';

// import '../repositories/authentication_repository_test.dart';
void main() {
  late LogInUseCase useCase;
  late MockAuthenticationRepository mockRepo;
  setUp(() {
    mockRepo = MockAuthenticationRepository();
    useCase = LogInUseCase(mockRepo);
  });

  final testUsername = "abcdefg";
  final testPassword = "123456";
  final Session session = Session(access: " ", refresh: " ");

  test("should return session", () async {
    // arrange
    when(mockRepo.logIn(any, any)).thenAnswer((_) async => Success(session));
    // act
    final result = await useCase.execute(testUsername, testPassword);
    // assert
    expect(result.getSuccess(), session);
    verify(mockRepo.logIn(testUsername, testPassword));
    verifyNoMoreInteractions(mockRepo);
  });
}
