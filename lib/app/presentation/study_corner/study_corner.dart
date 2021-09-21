import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:flutter/material.dart';

class StudyCorner extends StatelessWidget {
  const StudyCorner({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.red,
        title: Text("Góc học tập",
          style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.background,
      body: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              _item(context, Icons.schedule, Colors.blue, "Thời khoá biểu", AppRoute.listSchedules),
              _devider(),
              _item(context, Icons.event, Colors.orange, "Sự kiện", AppRoute.listSchedules),
              _devider(),
              _item(context, Icons.pie_chart_rounded, Colors.red, "Kết quả học tập", AppRoute.result),
              _devider(),
              _item(context, Icons.people_alt_rounded, Colors.green, "Lớp tín chỉ", AppRoute.listSchedules),
              _devider(),
              _item(context, Icons.person, Colors.purple, "Lớp hành chính", AppRoute.listSchedules),
            ],
          ),
        ),
      ),
    );
  }

  Widget _devider() {
    return Container(
      color: Colors.black12,
      height: 0.7,
      width: double.infinity,
    );
  }

  Widget _item(BuildContext context, IconData data, Color iconColor,String title, String nextRoute) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, nextRoute);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(data,color: iconColor,),
            SizedBox(width: 16,),
            Text(title),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,
              color: Colors.black12,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}