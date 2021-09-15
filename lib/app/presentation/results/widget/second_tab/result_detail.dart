import 'package:flutter/material.dart';

import 'package:fakeslink/app/domain/entities/register.dart';
import 'package:fakeslink/core/const/app_colors.dart';

class ResultDetail extends StatelessWidget {
  final Register register;
  const ResultDetail({
    Key? key,
    required this.register,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Chi tiết điểm",
          style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16),
              child: Text(register.registerableClass.subject.subjectName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            _detail(),
            Divider(thickness: 1,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text("Tổng kết số:",
                    style: TextStyle(
                      color: AppColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Spacer(),
                  Text(register.total.toString(),
                    style: TextStyle(
                      color: AppColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text("Tổng kết chữ:",
                    style: TextStyle(
                      color: AppColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Spacer(),
                  Text(_getTongKetChu(),
                    style: TextStyle(
                      color: AppColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getTongKetChu() {
    double d = register.total!;
    if(register.registerableClass.subject.isCPA) {
      if(d < 4) return "F";
      else if (d < 5) return "D";
      else if (d < 5.5) return "D+";
      else if (d < 6.5) return "C";
      else if (d < 7) return "C+";
      else if (d < 8) return "B";
      else if (d < 8.5) return "B+";
      else if (d < 9) return "A";
      else return "A+";
    } else {
      if(d<4) return "KĐ";
      else return "Đ";
    }
  }

  Widget _detail() {
    if(register.points?.length == 4 && !register.registerableClass.subject.subjectName.contains("Tiếng Anh")) {
      register.points?.add(0);
      register.registerableClass.subject.coefficient.add(register.registerableClass.subject.coefficient.last);
    }
    int index = -1;
    var titles = [];
    if(!register.registerableClass.subject.subjectName.contains("Tiếng Anh")) 
      titles = ["Điểm chuyên cần ", "Kiểm tra thường xuyên ", "Điểm bài tập ", "Điểm thi lần 1 ", "Điểm thi lần 2 "];
    else
      titles = ["Điểm nghe ","Điểm nói ", "Điểm đọc ", "Điểm viết "];
    return Column(
      children: register.registerableClass.subject.coefficient.map((e) {
        index++;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: titles[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                      text: "($e%)",
                      style: TextStyle(
                        fontWeight: FontWeight.normal
                      )
                    )
                  ]
                ),
              ),
              const Spacer(),
              Text(
                register.points![index].toString(),
                style: TextStyle(
                  color: AppColor.red,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        );
      }
      ).toList(),
    );
  }
}
