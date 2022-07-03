import 'dart:async';

import 'package:fakeslink/app/domain/entities/notification.dart' as n;
import 'package:fakeslink/app/presentation/home/bloc/home_notifications_bloc.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeNotifications extends StatefulWidget {
  const HomeNotifications({Key? key}) : super(key: key);

  @override
  _HomeNotificationsState createState() => _HomeNotificationsState();
}

class _HomeNotificationsState extends State<HomeNotifications>
    with SingleTickerProviderStateMixin {
  late final HomeNotificationsBloc _bloc;
  late final ScrollController _scrollController;
  int _currentIndex = 0;
  bool _isUserInteracting = false;
  double _itemWidth = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance()..add(HomeNotificationsInitEvent());
    _scrollController = new ScrollController();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (!_isUserInteracting && _scrollController.hasClients) {
        _currentIndex++;
        _scrollController.animateTo(_itemWidth * _currentIndex,
            duration: Duration(milliseconds: 250), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer.cancel();
    _bloc.close();
    super.dispose();
  }

  void _navigateToDetail(context, n.Notification notification) {
    Navigator.of(context).pushNamed(AppRoute.notificationDetails,
        arguments: notification.details);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNotificationsBloc, HomeNotificationsState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is HomeNotificationsLoadingState)
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: AppColor.black,
            ),
          );
        else if (state is HomeNotificationErrorState)
          return Center(child: Text("\n\nKhông có thông báo mới"));
        final notifications =
            (state as HomeNotificationsSuccessfulState).notifications;
        if (notifications.length == 0) {
          return Center(child: Text("\n\nKhông có thông báo mới"));
        } else {
          _itemWidth = (MediaQuery.of(context).size.width / 2 - 16);
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemBuilder: (context, index) {
                final e = notifications[index % notifications.length];
                return GestureDetector(
                  onPanStart: (_) {
                    _isUserInteracting = true;
                  },
                  onTap: () {
                    _navigateToDetail(context, e);
                  },
                  onPanEnd: (_) {
                    _isUserInteracting = false;
                  },
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 2.4 - 70,
                        width: MediaQuery.of(context).size.width / 2 - 32,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/notification.png"),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 16,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          e.details.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                );
              });
        }
      },
    );
  }
}
