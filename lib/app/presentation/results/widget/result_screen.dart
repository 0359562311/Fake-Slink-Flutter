import 'package:fakeslink/app/presentation/results/bloc/result_bloc.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_event.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_state.dart';
import 'package:fakeslink/app/presentation/results/widget/first_tab/result_first_tab.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'second_tab/list_result_detail.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ResultBloc _bloc;
  late final _items;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _bloc = GetIt.instance()..add(ResultInitEvent());
    _items = [const ResultFirstTab(), ListResultDetail()];
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.background,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Góc học tập", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: AppColor.red,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: "Môn học",
              ),
              Tab(
                text: "Điểm thi",
              ),
            ],
          )),
      body: BlocProvider<ResultBloc>(
        create: (context) => _bloc,
        child: BlocBuilder<ResultBloc, ResultState>(
          builder: (context, state) {
            if (state is ResultLoadingState)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (state is ResultErrorState) {
              return InkWell(
                onTap: () {
                  _bloc.add(ResultInitEvent());
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Đã có lỗi xảy ra\n Chạm để thử lại"),
                  ),
                ),
              );
            }
            return TabBarView(
              controller: _tabController,
              children: _items,
            );
          },
        ),
      ),
    );
  }
}
