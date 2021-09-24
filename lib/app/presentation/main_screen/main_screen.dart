import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakeslink/app/presentation/home/ui/home_view.dart';
import 'package:fakeslink/app/presentation/main_screen/bottom_bar.dart';
import 'package:fakeslink/app/presentation/notifications/ui/list_notification.dart';
import 'package:fakeslink/app/presentation/study_corner/study_corner.dart';
import 'package:fakeslink/app/presentation/utilities/utilities.dart';
import 'package:fakeslink/core/custom_widgets/custom_dialog.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  late List<Widget> _screens;
  late final subscription;

  void initState() {
    super.initState();
    _checkConnectivity();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      NetworkInfo.isConnecting = result != ConnectivityResult.none;
      if (!NetworkInfo.isConnecting) {
        showMyAlertDialog(
            context, "Lỗi kết nối", "Kiểm tra lại kết nối internet của bạn");
      }
    });
    GetIt.instance<StreamController<String>>().stream.asBroadcastStream().listen((event) {
      showMyAlertDialog(context, "Đã có lỗi xảy ra", event);
    });
    _screens = [HomeView(), ListNotification(), StudyCorner(), Utilities(), Scaffold()];
  }

  Future<void> _checkConnectivity() async {
    await Future.delayed(Duration(seconds: 2));
    if (!NetworkInfo.isConnecting) {
        showMyAlertDialog(context, "Lỗi kết nối", "Kiểm tra lại kết nối internet của bạn");
      }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: IndexedStack(
              children: _screens,
              index: _index,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: 110,
            child: MyBottomBar(
              onChange: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          )
        ]),
      ),
    );
  }
}
