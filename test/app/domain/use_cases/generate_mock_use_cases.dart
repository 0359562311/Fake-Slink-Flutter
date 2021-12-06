import 'package:fakeslink/app/domain/use_cases/create_notification_device_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/delete_notification_device_usercase.dart';
import 'package:fakeslink/app/domain/use_cases/get_administrative_class_details.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_notifications_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_register_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_schedule_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/get_profile_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_registerable_class_details_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/login_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/login_with_fingerprint_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/set_up_fingerprint_auth_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  CreateNotificationDeviceUseCase,
  DeleteNotificationDeviceUseCase,
  GetAdministrativeClassDetailsUseCase,
  GetListNotificationsUseCase,
  GetListRegisterUseCase,
  GetListScheduleUseCase,
  GetProfileUseCase,
  GetRegisterableClassDetailsUseCase,
  LogInUseCase,
  LogInWithFingeprintUseCase,
  MarkNotificationAsReadUseCase,
  SetUpFingerPrintAuthUseCase
])
void main() {}
