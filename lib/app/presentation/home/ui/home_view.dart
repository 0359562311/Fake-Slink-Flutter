import 'package:fakeslink/app/presentation/home/bloc/home_header_bloc.dart';
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
          SliverGrid.count(crossAxisCount: 2,
            childAspectRatio: 3,
            children: List.generate(4, (index){
              return Container(
                height: 50,
                margin: index.isEven?EdgeInsets.only(left: 16,right: 8):EdgeInsets.only(right: 16,left: 8),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(Icons.book,color: Colors.blue,size: 18,),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text("Thoi khoa bieu  ss",maxLines: 2,),
                      ),
                    )
                  ],
                ),
              );
            }),
            mainAxisSpacing: 12,
          ),
          HomeSchedule(),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context,index) => Text("$index")
          ))
        ],
      )
    );
  }
}