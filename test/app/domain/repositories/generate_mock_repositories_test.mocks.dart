// Mocks generated by Mockito 5.0.16 from annotations
// in fakeslink/test/app/domain/repositories/generate_mock_repositories_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:fakeslink/app/domain/entities/administrative_class_detail.dart'
    as _i6;
import 'package:fakeslink/app/domain/entities/notification.dart' as _i10;
import 'package:fakeslink/app/domain/entities/register.dart' as _i12;
import 'package:fakeslink/app/domain/entities/registerable_class.dart' as _i13;
import 'package:fakeslink/app/domain/entities/schedule.dart' as _i15;
import 'package:fakeslink/app/domain/entities/session.dart' as _i8;
import 'package:fakeslink/app/domain/entities/student.dart' as _i17;
import 'package:fakeslink/app/domain/repositories/administrative_class_repository.dart'
    as _i3;
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart'
    as _i7;
import 'package:fakeslink/app/domain/repositories/notification_repository.dart'
    as _i9;
import 'package:fakeslink/app/domain/repositories/register_repository.dart'
    as _i11;
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart'
    as _i14;
import 'package:fakeslink/app/domain/repositories/student_repository.dart'
    as _i16;
import 'package:fakeslink/core/architecture/failure.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:multiple_result/multiple_result.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResult_0<E, S> extends _i1.Fake implements _i2.Result<E, S> {}

/// A class which mocks [AdministrativeClassRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdministrativeClassRepository extends _i1.Mock
    implements _i3.AdministrativeClassRepository {
  MockAdministrativeClassRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.Failure, _i6.AdministrativeClassDetails>>
      getDetails() => (super.noSuchMethod(Invocation.method(#getDetails, []),
              returnValue: Future<
                      _i2.Result<_i5.Failure,
                          _i6.AdministrativeClassDetails>>.value(
                  _FakeResult_0<_i5.Failure, _i6.AdministrativeClassDetails>()))
          as _i4.Future<_i2.Result<_i5.Failure, _i6.AdministrativeClassDetails>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [AuthenticationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationRepository extends _i1.Mock
    implements _i7.AuthenticationRepository {
  MockAuthenticationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.Failure, _i8.Session>> logIn(
          String? username, String? password) =>
      (super.noSuchMethod(Invocation.method(#logIn, [username, password]),
              returnValue: Future<_i2.Result<_i5.Failure, _i8.Session>>.value(
                  _FakeResult_0<_i5.Failure, _i8.Session>()))
          as _i4.Future<_i2.Result<_i5.Failure, _i8.Session>>);
  @override
  _i4.Future<_i2.Result<_i5.Failure, _i8.Session>> logInWithFingerprint() =>
      (super.noSuchMethod(Invocation.method(#logInWithFingerprint, []),
              returnValue: Future<_i2.Result<_i5.Failure, _i8.Session>>.value(
                  _FakeResult_0<_i5.Failure, _i8.Session>()))
          as _i4.Future<_i2.Result<_i5.Failure, _i8.Session>>);
  @override
  _i4.Future<_i2.Result<_i5.Failure, void>> setUpFingerprintAuth(
          String? password) =>
      (super.noSuchMethod(Invocation.method(#setUpFingerprintAuth, [password]),
              returnValue: Future<_i2.Result<_i5.Failure, void>>.value(
                  _FakeResult_0<_i5.Failure, void>()))
          as _i4.Future<_i2.Result<_i5.Failure, void>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NotificationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationRepository extends _i1.Mock
    implements _i9.NotificationRepository {
  MockNotificationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<void, void>> createNotificationDevice(
          String? deviceId, String? oneSignalId) =>
      (super.noSuchMethod(
          Invocation.method(#createNotificationDevice, [deviceId, oneSignalId]),
          returnValue: Future<_i2.Result<void, void>>.value(
              _FakeResult_0<void, void>())) as _i4
          .Future<_i2.Result<void, void>>);
  @override
  _i4.Future<_i2.Result<void, void>> deleteNotificationDevice(
          String? deviceId) =>
      (super.noSuchMethod(
              Invocation.method(#deleteNotificationDevice, [deviceId]),
              returnValue: Future<_i2.Result<void, void>>.value(
                  _FakeResult_0<void, void>()))
          as _i4.Future<_i2.Result<void, void>>);
  @override
  _i4.Future<_i2.Result<_i5.Failure, List<_i10.Notification>>>
      getListNotifications(int? offset, String? type) => (super.noSuchMethod(
          Invocation.method(#getListNotifications, [offset, type]),
          returnValue:
              Future<_i2.Result<_i5.Failure, List<_i10.Notification>>>.value(
                  _FakeResult_0<_i5.Failure, List<_i10.Notification>>())) as _i4
          .Future<_i2.Result<_i5.Failure, List<_i10.Notification>>>);
  @override
  _i4.Future<_i2.Result<void, void>> markeAsRead(
          _i10.NotificationDetails? details) =>
      (super.noSuchMethod(Invocation.method(#markeAsRead, [details]),
              returnValue: Future<_i2.Result<void, void>>.value(
                  _FakeResult_0<void, void>()))
          as _i4.Future<_i2.Result<void, void>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RegisterRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegisterRepository extends _i1.Mock
    implements _i11.RegisterRepository {
  MockRegisterRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.Failure, List<_i12.Register>>> getListRegister() =>
      (super.noSuchMethod(Invocation.method(#getListRegister, []),
              returnValue:
                  Future<_i2.Result<_i5.Failure, List<_i12.Register>>>.value(
                      _FakeResult_0<_i5.Failure, List<_i12.Register>>()))
          as _i4.Future<_i2.Result<_i5.Failure, List<_i12.Register>>>);
  @override
  _i4.Future<_i2.Result<_i5.Failure, _i13.RegisterableClass>> getDetails(
          int? registerableClassId) =>
      (super.noSuchMethod(Invocation.method(#getDetails, [registerableClassId]),
              returnValue:
                  Future<_i2.Result<_i5.Failure, _i13.RegisterableClass>>.value(
                      _FakeResult_0<_i5.Failure, _i13.RegisterableClass>()))
          as _i4.Future<_i2.Result<_i5.Failure, _i13.RegisterableClass>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [ScheduleRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockScheduleRepository extends _i1.Mock
    implements _i14.ScheduleRepository {
  MockScheduleRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.Failure, List<_i15.Schedule>>> getListSchedule() =>
      (super.noSuchMethod(Invocation.method(#getListSchedule, []),
              returnValue:
                  Future<_i2.Result<_i5.Failure, List<_i15.Schedule>>>.value(
                      _FakeResult_0<_i5.Failure, List<_i15.Schedule>>()))
          as _i4.Future<_i2.Result<_i5.Failure, List<_i15.Schedule>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [StudentRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockStudentRepository extends _i1.Mock implements _i16.StudentRepository {
  MockStudentRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.Failure, _i17.Student>> getProfile() =>
      (super.noSuchMethod(Invocation.method(#getProfile, []),
              returnValue: Future<_i2.Result<_i5.Failure, _i17.Student>>.value(
                  _FakeResult_0<_i5.Failure, _i17.Student>()))
          as _i4.Future<_i2.Result<_i5.Failure, _i17.Student>>);
  @override
  _i4.Future<_i2.Result<_i5.Failure, _i17.Student>> updateProfile(
          String? avatar,
          String? cover,
          String? address,
          String? phoneNumber) =>
      (super.noSuchMethod(
              Invocation.method(
                  #updateProfile, [avatar, cover, address, phoneNumber]),
              returnValue: Future<_i2.Result<_i5.Failure, _i17.Student>>.value(
                  _FakeResult_0<_i5.Failure, _i17.Student>()))
          as _i4.Future<_i2.Result<_i5.Failure, _i17.Student>>);
  @override
  String toString() => super.toString();
}
