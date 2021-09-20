import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_bloc.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ResultTableAndDetail extends StatefulWidget {
  const ResultTableAndDetail({Key? key}) : super(key: key);

  @override
  _ResultTableAndDetailState createState() => _ResultTableAndDetailState();
}

class _ResultTableAndDetailState extends State<ResultTableAndDetail> {
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
    final _bloc = BlocProvider.of<ResultBloc>(context);
    return Column(
      children: [
        Align(
          child: _dropdownButton(),
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                child: Row(
                  children: [
                    Text("Số TC hoàn thành: "),
                    Text(
                      _bloc.register.where((element) => element.registerableClass.semester == current 
                        && element.total != null && element.total! >= 4
                      )
                      .fold<int>(0, (previousValue, element) => previousValue + element.registerableClass.subject.tinchi).toString(),
                      style: TextStyle(color: AppColor.red),
                    ),
                    Spacer(),
                    Text("TC chưa hoàn thành: "),
                    Text(
                      _bloc.register.where((element) => element.registerableClass.semester == current 
                        && (element.total == null || element.total! < 4)
                      )
                      .fold<int>(0, (previousValue, element) => previousValue + element.registerableClass.subject.tinchi).toString(),
                      style: TextStyle(color: AppColor.red),
                    ),
                  ],
                ),
              ),
              _table(_bloc),
              SizedBox(height: 30,)
            ],
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

  Widget _table(ResultBloc _bloc) {
    int index = 0;
    final _tableRows = <TableRow>[];
    _bloc.register.where((register) => register.registerableClass.semester == current)
      .forEach((element) { 
        index++;
        _tableRows.add(
          TableRow(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    index.toString(),
                    style: TextStyle(color: AppColor.black),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    element.registerableClass.subject.subjectName,
                    style: TextStyle(color: AppColor.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    element.registerableClass.subject.tinchi.toString(),
                    style: TextStyle(color: AppColor.black),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    element.total?.toString()??"",
                    style: TextStyle(color: AppColor.black),
                  ),
                ),
              ),
            ]
          )
        );
      });
    return Table(
      border: TableBorder.all(color: AppColor.background, width: 2),
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        TableRow(children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: AppColor.red,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "STT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: AppColor.red,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "Tên học phần",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: AppColor.red,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "Số tín chỉ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: AppColor.red,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "Tổng kết",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ,]),
        ..._tableRows
      ],
    );
  }
}
