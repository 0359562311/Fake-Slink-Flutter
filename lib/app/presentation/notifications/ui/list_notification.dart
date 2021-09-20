import 'package:fakeslink/app/presentation/notifications/bloc/notification_bloc.dart';
import 'package:fakeslink/app/presentation/notifications/ui/notification_tab.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNotification extends StatefulWidget {
  const ListNotification({ Key? key }) : super(key: key);

  @override
  _ListNotificationState createState() => _ListNotificationState();
}

class _ListNotificationState extends State<ListNotification> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late NotificationBloc _bloc;
  late List<Widget> _items;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _bloc = NotificationBloc();
    _items = [
      NotificationTab(type: 'General'),
      NotificationTab(type: 'Administrative'),
      NotificationTab(type: 'Registerable'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text("Thông báo",
          style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "Chung",),
            Tab(text: "Lớp tín chỉ",),
            Tab(text: "Lớp hành chính",),
          ],
        )
      ),
      body: BlocProvider.value(value: _bloc,
        child: TabBarView(
          controller: _tabController,
          children: _items,
        ),
      ),
    );
  }
}