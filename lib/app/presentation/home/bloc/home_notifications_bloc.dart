import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/notification.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_notifications_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
  late GetListNotificationsUseCase _getListNotificationsUseCase;
  HomeNotificationsBloc() : super(HomeNotificationsLoadingState()){
    _getListNotificationsUseCase = GetIt.instance();
  }

  @override
  Stream<HomeNotificationsState> mapEventToState(HomeNotificationsEvent event) async* {
    try {
      if (event == HomeNotificationsEvent.init) {
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