import 'package:fakeslink/app/domain/repositories/administrative_class_repository.dart';
import 'package:fakeslink/app/domain/repositories/authentication_repository.dart';
import 'package:fakeslink/app/domain/repositories/notification_repository.dart';
import 'package:fakeslink/app/domain/repositories/register_repository.dart';
import 'package:fakeslink/app/domain/repositories/schedule_repository.dart';
import 'package:fakeslink/app/domain/repositories/student_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AdministrativeClassRepository,
  AuthenticationRepository,
  NotificationRepository,
  RegisterRepository,
  ScheduleRepository,
  StudentRepository
])
void main() {}
