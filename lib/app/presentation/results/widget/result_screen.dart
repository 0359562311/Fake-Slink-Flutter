import 'package:fakeslink/app/presentation/results/widget/result_chart.dart';
import 'package:fakeslink/app/presentation/results/widget/result_detail.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({ Key? key }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late PageController _pageController;
  final _items = [ResultChart(), ResultDetail()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: PageView(
        controller: _pageController,
        children: _items,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
      ),
    );
  }
}