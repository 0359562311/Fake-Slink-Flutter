import 'dart:async';

import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_notifications_use_case.dart';
import 'package:fakeslink/app/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'package:fakeslink/app/presentation/notifications/bloc/notification_event.dart';
import 'package:fakeslink/app/presentation/notifications/bloc/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetListNotificationsUseCase _listNotificationsUseCase;
  final MarkNotificationAsReadUseCase _markNotificationAsReadUseCase;
  NotificationBloc(
      this._listNotificationsUseCase, this._markNotificationAsReadUseCase)
      : super(NotificationLoadingState('General')) {
    on<NotificationInitEvent>(_onInit);
    on<NotificationRefreshEvent>(_onRefresh);
    on<NotificationMarkAsSeenEvent>(_onMarkAsSeen);
    on<NotificationLoadMoreEvent>(_onLoadMore);
  }

  Map<String, List<Notification>> _notifications = {
    'General': [],
    'Administrative': [],
    'Registerable': [],
  };

  Map<String, List<Notification>> get notification => _notifications;

  Map<String, bool> _isLoading = {};

  FutureOr<void> _onInit(
      NotificationInitEvent event, Emitter<NotificationState> emit) async {
    if (!(_isLoading[event.type] ?? false)) {
      emit(NotificationLoadingState(event.type));
      final res = await _listNotificationsUseCase
          .execute(0, event.type)
          .whenComplete(() {
        _isLoading[event.type] = false;
      });
      if (res.isSuccess()) {
        _notifications[event.type] = res.getSuccess()!;
        emit(NotificationSuccessfulState(event.type));
      } else {
        emit(NotificationErrorState(event.type, res.getError()!.message));
      }
    }
  }

  FutureOr<void> _onRefresh(
      NotificationRefreshEvent event, Emitter<NotificationState> emit) async {
    if (!(_isLoading[event.type] ?? false)) {
      if (event is NotificationInitEvent)
        emit(NotificationLoadingState(event.type));
      final res = await _listNotificationsUseCase
          .execute(0, event.type)
          .whenComplete(() {
        _isLoading[event.type] = false;
      });
      if (res.isSuccess()) {
        _notifications[event.type] = res.getSuccess()!;
        emit(NotificationSuccessfulState(event.type));
      } else {
        emit(NotificationErrorState(event.type, res.getError()!.message));
      }
    }
  }

  FutureOr<void> _onMarkAsSeen(NotificationMarkAsSeenEvent event,
      Emitter<NotificationState> emit) async {
    _markNotificationAsReadUseCase.execute(event.details);
    _notifications[event.type]![event.index].seen = true;
  }

  FutureOr<void> _onLoadMore(
      NotificationLoadMoreEvent event, Emitter<NotificationState> emit) async {
    if (!(_isLoading[event.type] ?? false)) {
      final res = await _listNotificationsUseCase
          .execute(_notifications[event.type]!.length, event.type)
          .whenComplete(() {
        _isLoading[event.type] = false;
      });
      if (res.isSuccess()) {
        _notifications[event.type]?.addAll(res.getSuccess()!);
      }
      emit(NotificationSuccessfulState(event.type));
    }
  }
}
