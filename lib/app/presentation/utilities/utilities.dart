import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:flutter/material.dart';

class Utilities extends StatelessWidget {
  const Utilities({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _items1 = [
      _item(context, Icons.article, Colors.blue, "Tin tức", AppRoute.listSchedules),
      _item(context, Icons.book, Colors.red, "Giới thiệu về PTIT", AppRoute.listSchedules),
      _item(context, Icons.bookmark_add_rounded, Colors.orange, "Văn bản hướng dẫn", AppRoute.listSchedules),
      _item(context, Icons.feedback, Colors.green, "Dịch vụ 1 cửa", AppRoute.listSchedules),
    ];
    final _items2 = [
      _item(context, Icons.feedback, Colors.orange, "Phản hồi", AppRoute.listSchedules),
      _item(context, Icons.feedback, Colors.purple, "Khảo sát", AppRoute.listSchedules),
      _item(context, Icons.person, Colors.blue, "Khai báo sức khoẻ", AppRoute.listSchedules),
      _item(context, Icons.qr_code, Colors.greenAccent, "Quét mã QR", AppRoute.listSchedules),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.red,
        title: Text("Tiện ích",
          style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          _block(_items1),
          _block(_items2),
        ],
      ),
    );
  }

  Widget _block(List<Widget> items) {
    return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: IntrinsicHeight(
          child: Column(
            children: List.generate(items.length*2-1, (index){
              if(index % 2 == 1)
                return _devider();
              return items[index~/2];
            }),
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
        // Navigator.pushNamed(context, nextRoute);
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