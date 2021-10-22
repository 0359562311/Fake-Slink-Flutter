import 'package:dio/dio.dart';
import 'package:fakeslink/app/data/model/student_model.dart';
import 'package:fakeslink/app/data/sources/student_sources.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import '../../../main_test.dart';
import '../../../main_test.mocks.dart';
import '../repositories/student_repository_impl_test.mocks.dart';

void main() {
  late StudentLocalSource localSource;
  late StudentRemoteSouce remoteSource;
  late MockHiveInterface mockHiveInterface;
  late MockBox mockBox;
  late DioAdapter dioAdapter;
  setUpAll(() {
    registerDependencies();
    localSource = StudentLocalSource();
    remoteSource = StudentRemoteSouce();
    mockHiveInterface = GetIt.instance<MockHiveInterface>();
    mockBox = GetIt.instance<MockBox>();
    dioAdapter = GetIt.instance<DioAdapter>();
  });
  tearDownAll(() => unregisterDependencies());
  group('student remote source', () {
    test('get profile successfully', () async {
      // Arrange
      dioAdapter.onGet(APIPath.me, (server) {
        server.reply(200, {
          "studentId": "B18DCCN526",
          "administrativeClass": {
            "id": 1,
            "administrativeClassId": "D18CQCN09-B",
            "faculty": "Công nghệ thông tin",
            "lecturer": 1
          },
          "gpa": 4.1,
          "id": 3,
          "name": "Nguyễn Kiêm Tân",
          "dob": "2000-12-03",
          "address": "Ha Tay",
          "avatar":
              "https://i.pinimg.com/originals/5b/b9/59/5bb95935defd974fa87b44eaa8ed9bcd.jpg",
          "cover":
              "https://i.pinimg.com/originals/5b/b9/59/5bb95935defd974fa87b44eaa8ed9bcd.jpg",
          "gender": "Male",
          "role": "Student",
          "phoneNumber": "0359562311",
          "createAt": "2021-08-17T06:19:27.424211+07:00",
          "updateAt": "2021-08-22T21:32:58.833699+07:00"
        });
      });
      // Action
      final res = await remoteSource.getProfile();
      // Assert
      expect(res, TypeMatcher<StudentModel>());
    });

    test('get profile fail', () {
      // Arrange
      dioAdapter.onGet(APIPath.me, (server) {
        server.reply(400, {});
      });
      // Action
      final call = remoteSource.getProfile;
      // Assert
      expect(call(), throwsA(TypeMatcher<DioError>()));
    });
  });

  group('student local source', () {
    test('getProfile', () async {
      // Arrange
      when(mockHiveInterface.openBox("user"))
          .thenAnswer((realInvocation) async => mockBox);
      when(mockBox.get("data")).thenReturn(null);
      // Action
      await localSource.getProfile();
      // Assert
      verify(mockBox.get("data"));
      verify(mockHiveInterface.openBox("user"));
    });
  });

  test('cache user', () async {
    // Arrange
    when(mockHiveInterface.openBox("user"))
        .thenAnswer((realInvocation) async => mockBox);
    when(mockBox.clear()).thenAnswer((_) async => 0);
    // Action
    await localSource.cacheUser(MockStudentModel());
    // Assert
    verify(mockBox.put("data", any));
    verify(mockHiveInterface.openBox("user"));
  });
}
