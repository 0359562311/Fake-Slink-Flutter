import 'package:fakeslink/app/domain/entities/notification.dart' as noti;
import 'package:fakeslink/app/presentation/notifications/bloc/notification_bloc.dart';
import 'package:fakeslink/app/presentation/notifications/bloc/notification_event.dart';
import 'package:fakeslink/app/presentation/notifications/bloc/notification_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationTab extends StatefulWidget {
  final String type;
  const NotificationTab({Key? key, required this.type}) : super(key: key);

  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab>
    with AutomaticKeepAliveClientMixin {
  late NotificationBloc _bloc;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    print("initState ${widget.type}");
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _bloc.add(NotificationLoadMoreEvent(widget.type));
        }
      });
    _bloc = BlocProvider.of(context)..add(NotificationInitEvent(widget.type));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder(
        buildWhen: (previous, next) {
          if (next is NotificationLoadingState)
            return next.type == widget.type;
          else if (next is NotificationSuccessfulState)
            return next.type == widget.type;
          return false;
        },
        builder: (context, state) {
          if (state is NotificationSuccessfulState) {
            return RefreshIndicator(
              onRefresh: () async {
                if(NetworkInfo.isConnecting)
                  _bloc.add(NotificationRefreshEvent(widget.type));
              },
              child: ListView.builder(
                itemCount: _bloc.notification[widget.type]!.length + 1,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  if (index == _bloc.notification[widget.type]!.length)
                    return SizedBox(
                      height: 70,
                    );
                  noti.Notification notification =
                      _bloc.notification[widget.type]![index];
                  return InkWell(
                    onTap: () {
                      if (!_bloc.notification[widget.type]![index].seen) {
                        _bloc.add(NotificationMarkAsSeenEvent(
                            _bloc.notification[widget.type]![index].details,
                            widget.type,
                            index));
                      }
                      Navigator.pushNamed(context, AppRoute.notificationDetails,
                              arguments: _bloc
                                  .notification[widget.type]![index].details)
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                ExactAssetImage("assets/images/ptit.png"),
                            radius: 18,
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.details.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  notification.details.details,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      notification.details.sender.name + ", ",
                                      style: TextStyle(
                                          color: AppColor.red, fontSize: 12),
                                    ),
                                    Text(
                                      notification.details.createAt,
                                      style: TextStyle(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 20,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: notification.seen
                                    ? Colors.white
                                    : AppColor.red),
                            alignment: Alignment.center,
                            child: Text(
                              "N",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                controller: _scrollController,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: AppColor.black,
            ),
          );
        },
        bloc: _bloc,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
