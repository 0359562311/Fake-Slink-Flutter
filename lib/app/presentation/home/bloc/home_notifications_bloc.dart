import 'dart:async';

import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/use_cases/create_notification_device_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_notifications_use_case.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

abstract class HomeNotificationsEvent {}

class HomeNotificationsInitEvent extends HomeNotificationsEvent {}

abstract class HomeNotificationsState {
  const HomeNotificationsState();
}

class HomeNotificationsLoadingState extends HomeNotificationsState {
  const HomeNotificationsLoadingState();
}

class HomeNotificationErrorState extends HomeNotificationsState {
  final String message;
  const HomeNotificationErrorState(this.message);
}

class HomeNotificationsSuccessfulState extends HomeNotificationsState {
  final List<Notification> notifications;

  HomeNotificationsSuccessfulState(this.notifications);
}

class HomeNotificationsBloc
    extends Bloc<HomeNotificationsEvent, HomeNotificationsState> {
  late final GetListNotificationsUseCase _getListNotificationsUseCase;
  late final CreateNotificationDeviceUseCase _createNotificationDeviceUseCase;
  HomeNotificationsBloc(
      this._getListNotificationsUseCase, this._createNotificationDeviceUseCase)
      : super(HomeNotificationsLoadingState()) {
    on<HomeNotificationsEvent>(onInit);
  }

  FutureOr<void> onInit(HomeNotificationsEvent event,
      Emitter<HomeNotificationsState> emit) async {
    if (GetIt.instance<DeviceInfo>().deviceId != null)
      OneSignal.shared.getDeviceState().then((value) {
        if (value != null)
          _createNotificationDeviceUseCase.execute(
              GetIt.instance<DeviceInfo>().deviceId!, value.userId!);
      });
    emit(HomeNotificationsLoadingState());
    final res = await _getListNotificationsUseCase.execute(0, "General");
    if (res.isSuccess())
      emit(HomeNotificationsSuccessfulState(res.getSuccess()!));
    else
      emit(HomeNotificationErrorState(res.getError()!.message));
  }
}
