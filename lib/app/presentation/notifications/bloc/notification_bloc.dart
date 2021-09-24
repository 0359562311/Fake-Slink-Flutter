import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_notifications_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'package:fakeslink/app/presentation/notifications/bloc/notification_event.dart';
import 'package:fakeslink/app/presentation/notifications/bloc/notification_state.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  late final GetListNotificationsUseCase _listNotificationsUseCase;
  late final MarkNotificationAsReadUseCase _markNotificationAsReadUseCase;
  NotificationBloc() : super(NotificationLoadingState('General')) {
    _listNotificationsUseCase = GetIt.instance<GetListNotificationsUseCase>();
    _markNotificationAsReadUseCase =
        GetIt.instance<MarkNotificationAsReadUseCase>();
  }

  Map<String, List<Notification>> _notifications = {
    'General': [],
    'Administrative': [],
    'Registerable': [],
  };

  Map<String, List<Notification>> get notification => _notifications;

  Map<String, bool> _isLoading = {};

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (NetworkInfo.isConnecting) {
      if (event is NotificationInitEvent || event is NotificationRefreshEvent) {

        if (!(_isLoading[event.type] ?? false)) {
          if (event is NotificationInitEvent)
            yield NotificationLoadingState(event.type);
          final res = await _listNotificationsUseCase
              .execute(0, event.type)
              .whenComplete(() {
            _isLoading[event.type] = false;
          });
          _notifications[event.type] = res;
          yield NotificationSuccessfulState(event.type);
        }

      } else if (event is NotificationMarkAsSeenEvent) {

        _markNotificationAsReadUseCase.execute(event.details);
        _notifications[event.type]![event.index].seen = true;

      } else if (event is NotificationLoadMoreEvent) {

        if (!(_isLoading[event.type] ?? false)) {
          final res = await _listNotificationsUseCase
              .execute(_notifications[event.type]!.length, event.type)
              .whenComplete(() {
            _isLoading[event.type] = false;
          });
          _notifications[event.type]?.addAll(res);
          yield NotificationSuccessfulState(event.type);
        }
        
      }
    }
  }
}
