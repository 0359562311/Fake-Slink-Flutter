import 'package:fakeslink/app/presentation/results/bloc/result_bloc.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_event.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_state.dart';
import 'package:fakeslink/app/presentation/results/widget/result_chart.dart';
import 'package:fakeslink/app/presentation/results/widget/list_result_detail.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({ Key? key }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late PageController _pageController;
  late ResultBloc _bloc;
  final _items = [ResultChart(), ListResultDetail()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    _bloc = ResultBloc()..add(ResultInitEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Góc học tập",
          style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          onTap: (index) {
            _pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.linear);
          },
          tabs: [
            Tab(text: "Môn học",),
            Tab(text: "Điểm thi",),
          ],
        )
      ),
      body: BlocProvider<ResultBloc>(
        create: (context) => _bloc,
        child: BlocConsumer<ResultBloc, ResultState>(
          listener: (context, state) {
            if(state is ResultErrorState) 
              showMyAlertDialog(context, "Lỗi", state.message);
          },
          listenWhen: (o,n) => n is ResultErrorState,
          builder: (context, state) {
            if(state is ResultLoadingState)
              return Center(
                child: CircularProgressIndicator(),
              );
            return PageView(
              controller: _pageController,
              children: _items,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
            );
          },
        ),
      ),
    );
  }
}