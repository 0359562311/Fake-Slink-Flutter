import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/use_cases/create_notification_device_usecase.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_notifications_use_case.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

enum HomeNotificationsEvent{
  init
}

abstract class HomeNotificationsState{
  const HomeNotificationsState();
}

class HomeNotificationsLoadingState extends HomeNotificationsState{
  const HomeNotificationsLoadingState();
}
class HomeNotificationsSuccessfulState extends HomeNotificationsState{
  final List<Notification> notifications;

  HomeNotificationsSuccessfulState(this.notifications);
}

class HomeNotificationsBloc extends Bloc<HomeNotificationsEvent,HomeNotificationsState>{
  late final GetListNotificationsUseCase _getListNotificationsUseCase;
  late final CreateNotificationDeviceUseCase _createNotificationDeviceUseCase;
  HomeNotificationsBloc(this._getListNotificationsUseCase, this._createNotificationDeviceUseCase) : super(HomeNotificationsLoadingState());

  @override
  Stream<HomeNotificationsState> mapEventToState(HomeNotificationsEvent event) async* {
    try {
      if (event == HomeNotificationsEvent.init) {
        if (DeviceInfo.deviceId != null)
            OneSignal.shared.getDeviceState().then((value){
              print("TanKiem: ${value?.userId}");
              if(value != null)
                _createNotificationDeviceUseCase.execute(
                  DeviceInfo.deviceId!, value.userId!);
            });
        yield HomeNotificationsLoadingState();
        yield HomeNotificationsSuccessfulState(
          await _getListNotificationsUseCase.execute(0, "General")
        );
      }
    } on DioError {
      yield HomeNotificationsSuccessfulState([]);
    }
  }

}