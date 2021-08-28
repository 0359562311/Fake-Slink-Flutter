import 'package:fakeslink/app/presentation/home/bloc/home_header_bloc.dart';
import 'package:fakeslink/app/presentation/home/ui/home_common_functions.dart';
import 'package:fakeslink/app/presentation/home/ui/home_schedule.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomScrollView(
      slivers: [
          BlocProvider.value(
            value: HomeHeaderBloc()..add(HomeHeaderEvent.init),
            child: SliverPersistentHeader(
              delegate: SliverHeaderChildDelegateImpl(),
              pinned: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "Chức năng phổ biến:",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          CommonFunction(),
          HomeSchedule(),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context,index) => Text("$index")
          ))
        ],
      )
    );
  }
}