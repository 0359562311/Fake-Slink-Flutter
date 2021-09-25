import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/entities/student.dart';
import 'package:fakeslink/app/presentation/results/bloc/result_bloc.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'result_detail.dart';

class ListResultDetail extends StatefulWidget {
  const ListResultDetail({Key? key}) : super(key: key);

  @override
  _ListResultDetailState createState() => _ListResultDetailState();
}

class _ListResultDetailState extends State<ListResultDetail> with AutomaticKeepAliveClientMixin<ListResultDetail> {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("TanKiem: didChangeDependencies in result_detail");
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<ResultBloc>(context);
    super.build(context);
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              child: _dropdownButton(),
              alignment: Alignment.center,
            ),
            _listResults(_bloc),
            SizedBox(
              height: 32,
            )
          ],
        ),
      ),
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

  Widget _listResults(ResultBloc bloc) {
    int index = 0;
    return Column(
      children: bloc.register
          .where((r) => r.registerableClass.semester == current)
          .map((e) {
        index++;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: InkWell(
            onTap: () {
              if (e.total != null)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultDetail(
                              register: e,
                            )));
            },
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.red),
                    alignment: Alignment.center,
                    child: Text(
                      "$index",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        e.registerableClass.subject.subjectName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Mã môn học: ${e.registerableClass.subject.subjectId}",
                        style: TextStyle(color: AppColor.black, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        e.total == null ? "Chưa có điểm" : "Đã có điểm",
                        style: TextStyle(
                            color:
                                e.total == null ? AppColor.red : Colors.green,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
