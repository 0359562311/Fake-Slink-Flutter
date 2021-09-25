import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ListRegisterableClassScreen extends StatefulWidget {
  const ListRegisterableClassScreen({ Key? key }) : super(key: key);

  @override
  _ListRegisterableClassScreenState createState() => _ListRegisterableClassScreenState();
}

class _ListRegisterableClassScreenState extends State<ListRegisterableClassScreen> {

  List<String> semesters = [];
  late String current;

  @override
  void initState() {
    super.initState();
    current = GetIt.instance<Semester>().semesterId;
    if (GetIt.instance.isRegistered<Student>()) {
      final user = GetIt.instance<Student>();
      String to = current;
      for (int i = int.parse(user.studentId.substring(1, 3));
          i <= int.parse(to.substring(2, 4));
          i++) {
        for (int j = 1; j <= 3; j++) {
          semesters.add("20$i$j");
          if (i == int.parse(to.substring(2, 4)) &&
              j == int.parse(to.substring(4))) break;
        }
      }
      semesters = semesters.reversed.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông báo",
          style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _dropdownButton(),
              _listRegisterableClass()
            ],
          ),
        ),
      ),
    );
  }

  Widget _listRegisterableClass() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
        )
      ],
    );
  }

  Widget _dropdownButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.3,
                  color: Colors.black87,
                  offset: Offset(0, 0.3))
            ],
            color: Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            items: semesters
                .map((str) => DropdownMenuItem(
                      value: str,
                      child: Text(
                        "Học kỳ ${str.substring(4)} - năm ${str.substring(0, 4)}",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      ),
                    ))
                .toList(),
            hint: Text(
                "Học kỳ ${current.substring(4)} - năm ${current.substring(0, 4)}"),
            onChanged: (val) {
              setState(() {
                current = val.toString();
              });
            },
          ),
        ));
  }
}