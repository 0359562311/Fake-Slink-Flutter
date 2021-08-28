import 'package:fakeslink/app/presentation/home/bloc/home_header_provider.dart';
import 'package:fakeslink/app/presentation/home/ui/home_common_functions.dart';
import 'package:fakeslink/app/presentation/home/ui/home_schedule.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'home_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final HomeHeaderProvider _homeHeaderProvider = HomeHeaderProvider();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomScrollView(
      slivers: [
          ChangeNotifierProvider.value(
            value: _homeHeaderProvider,
            child: SliverPersistentHeader(
              delegate: SliverHeaderChildDelegateImpl(),
              pinned: true,
              floating: true,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const Text(
                "Chức năng phổ biến:",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const CommonFunction(),
          HomeSchedule(),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context,index) => Text("$index")
          ))
        ],
      )
    );
  }
}