// Mocks generated by Mockito 5.0.16 from annotations
// in fakeslink/test/main_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;
import 'dart:typed_data' as _i17;

import 'package:dio/src/adapter.dart' as _i3;
import 'package:dio/src/cancel_token.dart' as _i12;
import 'package:dio/src/dio.dart' as _i11;
import 'package:dio/src/dio_error.dart' as _i13;
import 'package:dio/src/interceptor.dart' as _i5;
import 'package:dio/src/options.dart' as _i2;
import 'package:dio/src/response.dart' as _i6;
import 'package:dio/src/transformer.dart' as _i4;
import 'package:fakeslink/core/utils/device_info.dart' as _i10;
import 'package:fakeslink/core/utils/network_info.dart' as _i8;
import 'package:fakeslink/core/utils/share_preferences.dart' as _i14;
import 'package:hive/hive.dart' as _i7;
import 'package:hive/src/box/default_compaction_strategy.dart' as _i16;
import 'package:hive/src/box/default_key_comparator.dart' as _i15;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeBaseOptions_0 extends _i1.Fake implements _i2.BaseOptions {}

class _FakeHttpClientAdapter_1 extends _i1.Fake
    implements _i3.HttpClientAdapter {}

class _FakeTransformer_2 extends _i1.Fake implements _i4.Transformer {}

class _FakeInterceptors_3 extends _i1.Fake implements _i5.Interceptors {}

class _FakeResponse_4<T> extends _i1.Fake implements _i6.Response<T> {}

class _FakeRequestOptions_5 extends _i1.Fake implements _i2.RequestOptions {}

class _FakeBox_6<E> extends _i1.Fake implements _i7.Box<E> {}

class _FakeLazyBox_7<E> extends _i1.Fake implements _i7.LazyBox<E> {}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i8.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isConnecting =>
      (super.noSuchMethod(Invocation.getter(#isConnecting), returnValue: false)
          as bool);
  @override
  set isConnecting(bool? _isConnecting) =>
      super.noSuchMethod(Invocation.setter(#isConnecting, _isConnecting),
          returnValueForMissingStub: null);
  @override
  _i9.Future<void> init() => (super.noSuchMethod(Invocation.method(#init, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [DeviceInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeviceInfo extends _i1.Mock implements _i10.DeviceInfo {
  MockDeviceInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set deviceId(String? _deviceId) =>
      super.noSuchMethod(Invocation.setter(#deviceId, _deviceId),
          returnValueForMissingStub: null);
  @override
  set deviceName(String? _deviceName) =>
      super.noSuchMethod(Invocation.setter(#deviceName, _deviceName),
          returnValueForMissingStub: null);
  @override
  _i9.Future<dynamic> init() =>
      (super.noSuchMethod(Invocation.method(#init, []),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [Dio].
///
/// See the documentation for Mockito's code generation for more information.
class MockDio extends _i1.Mock implements _i11.Dio {
  MockDio() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BaseOptions get options =>
      (super.noSuchMethod(Invocation.getter(#options),
          returnValue: _FakeBaseOptions_0()) as _i2.BaseOptions);
  @override
  set options(_i2.BaseOptions? _options) =>
      super.noSuchMethod(Invocation.setter(#options, _options),
          returnValueForMissingStub: null);
  @override
  _i3.HttpClientAdapter get httpClientAdapter =>
      (super.noSuchMethod(Invocation.getter(#httpClientAdapter),
          returnValue: _FakeHttpClientAdapter_1()) as _i3.HttpClientAdapter);
  @override
  set httpClientAdapter(_i3.HttpClientAdapter? _httpClientAdapter) => super
      .noSuchMethod(Invocation.setter(#httpClientAdapter, _httpClientAdapter),
          returnValueForMissingStub: null);
  @override
  _i4.Transformer get transformer =>
      (super.noSuchMethod(Invocation.getter(#transformer),
          returnValue: _FakeTransformer_2()) as _i4.Transformer);
  @override
  set transformer(_i4.Transformer? _transformer) =>
      super.noSuchMethod(Invocation.setter(#transformer, _transformer),
          returnValueForMissingStub: null);
  @override
  _i5.Interceptors get interceptors =>
      (super.noSuchMethod(Invocation.getter(#interceptors),
          returnValue: _FakeInterceptors_3()) as _i5.Interceptors);
  @override
  void close({bool? force = false}) =>
      super.noSuchMethod(Invocation.method(#close, [], {#force: force}),
          returnValueForMissingStub: null);
  @override
  _i9.Future<_i6.Response<T>> get<T>(String? path,
          {Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#get, [
                path
              ], {
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> getUri<T>(Uri? uri,
          {_i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#getUri, [
                uri
              ], {
                #options: options,
                #cancelToken: cancelToken,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> post<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> postUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#postUri, [
                uri
              ], {
                #data: data,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> put<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> putUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#putUri, [
                uri
              ], {
                #data: data,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> head<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken}) =>
      (super.noSuchMethod(
              Invocation.method(#head, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> headUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken}) =>
      (super.noSuchMethod(
              Invocation.method(#headUri, [uri],
                  {#data: data, #options: options, #cancelToken: cancelToken}),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> delete<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> deleteUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken}) =>
      (super.noSuchMethod(
              Invocation.method(#deleteUri, [uri],
                  {#data: data, #options: options, #cancelToken: cancelToken}),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> patch<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> patchUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#patchUri, [
                uri
              ], {
                #data: data,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  void lock() => super.noSuchMethod(Invocation.method(#lock, []),
      returnValueForMissingStub: null);
  @override
  void unlock() => super.noSuchMethod(Invocation.method(#unlock, []),
      returnValueForMissingStub: null);
  @override
  void clear() => super.noSuchMethod(Invocation.method(#clear, []),
      returnValueForMissingStub: null);
  @override
  _i9.Future<_i6.Response<dynamic>> download(String? urlPath, dynamic savePath,
          {_i2.ProgressCallback? onReceiveProgress,
          Map<String, dynamic>? queryParameters,
          _i12.CancelToken? cancelToken,
          bool? deleteOnError = true,
          String? lengthHeader = r'content-length',
          dynamic data,
          _i2.Options? options}) =>
      (super.noSuchMethod(
              Invocation.method(#download, [
                urlPath,
                savePath
              ], {
                #onReceiveProgress: onReceiveProgress,
                #queryParameters: queryParameters,
                #cancelToken: cancelToken,
                #deleteOnError: deleteOnError,
                #lengthHeader: lengthHeader,
                #data: data,
                #options: options
              }),
              returnValue: Future<_i6.Response<dynamic>>.value(
                  _FakeResponse_4<dynamic>()))
          as _i9.Future<_i6.Response<dynamic>>);
  @override
  _i9.Future<_i6.Response<dynamic>> downloadUri(Uri? uri, dynamic savePath,
          {_i2.ProgressCallback? onReceiveProgress,
          _i12.CancelToken? cancelToken,
          bool? deleteOnError = true,
          String? lengthHeader = r'content-length',
          dynamic data,
          _i2.Options? options}) =>
      (super.noSuchMethod(
              Invocation.method(#downloadUri, [
                uri,
                savePath
              ], {
                #onReceiveProgress: onReceiveProgress,
                #cancelToken: cancelToken,
                #deleteOnError: deleteOnError,
                #lengthHeader: lengthHeader,
                #data: data,
                #options: options
              }),
              returnValue: Future<_i6.Response<dynamic>>.value(
                  _FakeResponse_4<dynamic>()))
          as _i9.Future<_i6.Response<dynamic>>);
  @override
  _i9.Future<_i6.Response<T>> request<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i12.CancelToken? cancelToken,
          _i2.Options? options,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#request, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #cancelToken: cancelToken,
                #options: options,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> requestUri<T>(Uri? uri,
          {dynamic data,
          _i12.CancelToken? cancelToken,
          _i2.Options? options,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#requestUri, [
                uri
              ], {
                #data: data,
                #cancelToken: cancelToken,
                #options: options,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  _i9.Future<_i6.Response<T>> fetch<T>(_i2.RequestOptions? requestOptions) =>
      (super.noSuchMethod(Invocation.method(#fetch, [requestOptions]),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i9.Future<_i6.Response<T>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [DioError].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioError extends _i1.Mock implements _i13.DioError {
  MockDioError() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RequestOptions get requestOptions =>
      (super.noSuchMethod(Invocation.getter(#requestOptions),
          returnValue: _FakeRequestOptions_5()) as _i2.RequestOptions);
  @override
  set requestOptions(_i2.RequestOptions? _requestOptions) =>
      super.noSuchMethod(Invocation.setter(#requestOptions, _requestOptions),
          returnValueForMissingStub: null);
  @override
  set response(_i6.Response<dynamic>? _response) =>
      super.noSuchMethod(Invocation.setter(#response, _response),
          returnValueForMissingStub: null);
  @override
  _i13.DioErrorType get type => (super.noSuchMethod(Invocation.getter(#type),
      returnValue: _i13.DioErrorType.connectTimeout) as _i13.DioErrorType);
  @override
  set type(_i13.DioErrorType? _type) =>
      super.noSuchMethod(Invocation.setter(#type, _type),
          returnValueForMissingStub: null);
  @override
  set error(dynamic _error) =>
      super.noSuchMethod(Invocation.setter(#error, _error),
          returnValueForMissingStub: null);
  @override
  set stackTrace(StackTrace? stack) =>
      super.noSuchMethod(Invocation.setter(#stackTrace, stack),
          returnValueForMissingStub: null);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SharePreferencesUtils].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharePreferencesUtils extends _i1.Mock
    implements _i14.SharePreferencesUtils {
  MockSharePreferencesUtils() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<dynamic> init() =>
      (super.noSuchMethod(Invocation.method(#init, []),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> setInt(String? key, int? value) =>
      (super.noSuchMethod(Invocation.method(#setInt, [key, value]),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  int? getInt(String? key) =>
      (super.noSuchMethod(Invocation.method(#getInt, [key])) as int?);
  @override
  _i9.Future<dynamic> setString(String? key, String? value) =>
      (super.noSuchMethod(Invocation.method(#setString, [key, value]),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  String? getString(String? key) =>
      (super.noSuchMethod(Invocation.method(#getString, [key])) as String?);
  @override
  _i9.Future<dynamic> reset() =>
      (super.noSuchMethod(Invocation.method(#reset, []),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  void clearSession() =>
      super.noSuchMethod(Invocation.method(#clearSession, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [HiveInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveInterface extends _i1.Mock implements _i7.HiveInterface {
  MockHiveInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void init(String? path) =>
      super.noSuchMethod(Invocation.method(#init, [path]),
          returnValueForMissingStub: null);
  @override
  _i9.Future<_i7.Box<E>> openBox<E>(String? name,
          {_i7.HiveCipher? encryptionCipher,
          _i7.KeyComparator? keyComparator = _i15.defaultKeyComparator,
          _i7.CompactionStrategy? compactionStrategy =
              _i16.defaultCompactionStrategy,
          bool? crashRecovery = true,
          String? path,
          _i17.Uint8List? bytes,
          List<int>? encryptionKey}) =>
      (super.noSuchMethod(
              Invocation.method(#openBox, [
                name
              ], {
                #encryptionCipher: encryptionCipher,
                #keyComparator: keyComparator,
                #compactionStrategy: compactionStrategy,
                #crashRecovery: crashRecovery,
                #path: path,
                #bytes: bytes,
                #encryptionKey: encryptionKey
              }),
              returnValue: Future<_i7.Box<E>>.value(_FakeBox_6<E>()))
          as _i9.Future<_i7.Box<E>>);
  @override
  _i9.Future<_i7.LazyBox<E>> openLazyBox<E>(String? name,
          {_i7.HiveCipher? encryptionCipher,
          _i7.KeyComparator? keyComparator = _i15.defaultKeyComparator,
          _i7.CompactionStrategy? compactionStrategy =
              _i16.defaultCompactionStrategy,
          bool? crashRecovery = true,
          String? path,
          List<int>? encryptionKey}) =>
      (super.noSuchMethod(
              Invocation.method(#openLazyBox, [
                name
              ], {
                #encryptionCipher: encryptionCipher,
                #keyComparator: keyComparator,
                #compactionStrategy: compactionStrategy,
                #crashRecovery: crashRecovery,
                #path: path,
                #encryptionKey: encryptionKey
              }),
              returnValue: Future<_i7.LazyBox<E>>.value(_FakeLazyBox_7<E>()))
          as _i9.Future<_i7.LazyBox<E>>);
  @override
  _i7.Box<E> box<E>(String? name) =>
      (super.noSuchMethod(Invocation.method(#box, [name]),
          returnValue: _FakeBox_6<E>()) as _i7.Box<E>);
  @override
  _i7.LazyBox<E> lazyBox<E>(String? name) =>
      (super.noSuchMethod(Invocation.method(#lazyBox, [name]),
          returnValue: _FakeLazyBox_7<E>()) as _i7.LazyBox<E>);
  @override
  bool isBoxOpen(String? name) =>
      (super.noSuchMethod(Invocation.method(#isBoxOpen, [name]),
          returnValue: false) as bool);
  @override
  _i9.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> deleteBoxFromDisk(String? name) =>
      (super.noSuchMethod(Invocation.method(#deleteBoxFromDisk, [name]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> deleteFromDisk() =>
      (super.noSuchMethod(Invocation.method(#deleteFromDisk, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  List<int> generateSecureKey() =>
      (super.noSuchMethod(Invocation.method(#generateSecureKey, []),
          returnValue: <int>[]) as List<int>);
  @override
  _i9.Future<bool> boxExists(String? name) =>
      (super.noSuchMethod(Invocation.method(#boxExists, [name]),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  String toString() => super.toString();
  @override
  void registerAdapter<T>(_i7.TypeAdapter<T>? adapter,
          {bool? internal = false, bool? override = false}) =>
      super.noSuchMethod(
          Invocation.method(#registerAdapter, [adapter],
              {#internal: internal, #override: override}),
          returnValueForMissingStub: null);
  @override
  bool isAdapterRegistered(int? typeId) =>
      (super.noSuchMethod(Invocation.method(#isAdapterRegistered, [typeId]),
          returnValue: false) as bool);
  @override
  void ignoreTypeId<T>(int? typeId) =>
      super.noSuchMethod(Invocation.method(#ignoreTypeId, [typeId]),
          returnValueForMissingStub: null);
}

/// A class which mocks [Box].
///
/// See the documentation for Mockito's code generation for more information.
class MockBox<E> extends _i1.Mock implements _i7.Box<E> {
  MockBox() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Iterable<E> get values =>
      (super.noSuchMethod(Invocation.getter(#values), returnValue: <E>[])
          as Iterable<E>);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  bool get isOpen =>
      (super.noSuchMethod(Invocation.getter(#isOpen), returnValue: false)
          as bool);
  @override
  bool get lazy =>
      (super.noSuchMethod(Invocation.getter(#lazy), returnValue: false)
          as bool);
  @override
  Iterable<dynamic> get keys =>
      (super.noSuchMethod(Invocation.getter(#keys), returnValue: <dynamic>[])
          as Iterable<dynamic>);
  @override
  int get length =>
      (super.noSuchMethod(Invocation.getter(#length), returnValue: 0) as int);
  @override
  bool get isEmpty =>
      (super.noSuchMethod(Invocation.getter(#isEmpty), returnValue: false)
          as bool);
  @override
  bool get isNotEmpty =>
      (super.noSuchMethod(Invocation.getter(#isNotEmpty), returnValue: false)
          as bool);
  @override
  Iterable<E> valuesBetween({dynamic startKey, dynamic endKey}) =>
      (super.noSuchMethod(
          Invocation.method(
              #valuesBetween, [], {#startKey: startKey, #endKey: endKey}),
          returnValue: <E>[]) as Iterable<E>);
  @override
  E? getAt(int? index) =>
      (super.noSuchMethod(Invocation.method(#getAt, [index])) as E?);
  @override
  Map<dynamic, E> toMap() => (super.noSuchMethod(Invocation.method(#toMap, []),
      returnValue: <dynamic, E>{}) as Map<dynamic, E>);
  @override
  String toString() => super.toString();
  @override
  dynamic keyAt(int? index) =>
      super.noSuchMethod(Invocation.method(#keyAt, [index]));
  @override
  _i9.Stream<_i7.BoxEvent> watch({dynamic key}) => (super.noSuchMethod(
      Invocation.method(#watch, [], {#key: key}),
      returnValue: Stream<_i7.BoxEvent>.empty()) as _i9.Stream<_i7.BoxEvent>);
  @override
  bool containsKey(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#containsKey, [key]),
          returnValue: false) as bool);
  @override
  _i9.Future<void> put(dynamic key, E? value) =>
      (super.noSuchMethod(Invocation.method(#put, [key, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> putAt(int? index, E? value) =>
      (super.noSuchMethod(Invocation.method(#putAt, [index, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> putAll(Map<dynamic, E>? entries) =>
      (super.noSuchMethod(Invocation.method(#putAll, [entries]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<int> add(E? value) =>
      (super.noSuchMethod(Invocation.method(#add, [value]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<Iterable<int>> addAll(Iterable<E>? values) =>
      (super.noSuchMethod(Invocation.method(#addAll, [values]),
              returnValue: Future<Iterable<int>>.value(<int>[]))
          as _i9.Future<Iterable<int>>);
  @override
  _i9.Future<void> delete(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#delete, [key]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> deleteAt(int? index) =>
      (super.noSuchMethod(Invocation.method(#deleteAt, [index]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> deleteAll(Iterable<dynamic>? keys) =>
      (super.noSuchMethod(Invocation.method(#deleteAll, [keys]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> compact() =>
      (super.noSuchMethod(Invocation.method(#compact, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<int> clear() => (super.noSuchMethod(Invocation.method(#clear, []),
      returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> deleteFromDisk() =>
      (super.noSuchMethod(Invocation.method(#deleteFromDisk, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
}
