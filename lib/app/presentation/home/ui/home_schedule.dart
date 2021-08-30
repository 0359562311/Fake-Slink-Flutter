import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/presentation/home/bloc/home_schedule_provider.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeSchedule extends StatefulWidget {
  const HomeSchedule({Key? key}) : super(key: key);

  @override
  _HomeScheduleState createState() => _HomeScheduleState();
}

class _HomeScheduleState extends State<HomeSchedule> {
  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  int index = 0;

  late HomeScheduleProvider _provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = HomeScheduleProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      builder: (context, child) {
        var _provider = Provider.of<HomeScheduleProvider>(context);
        return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(6)),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      if(index != 0) setState(() {
                         index = 0;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                          color: index == 0? AppColor.black : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Hôm nay",
                        style: TextStyle(
                            color: index == 0 ? Colors.white: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if(index != 1) setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: index == 1? AppColor.black : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Ngày mai",
                        style: TextStyle(
                            color: index == 1 ? Colors.white: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if (index != 2)
                        setState(() {
                          index = 2;
                        });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                          color: index == 2? AppColor.black : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Ngày kia",
                        style: TextStyle(
                            color: (index == 2 ? Colors.white: Colors.black54),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              (_provider.tempClasses.length == 0) ? Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CircularProgressIndicator(),
              ) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _provider.tempClasses[index].length == 0 
                ? [Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text("Không có lịch học", style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14
                  ),)
                )]
                :List.generate(_provider.tempClasses[index].length, (_index){
                  final _tempClass = _provider.tempClasses[index][_index];
                  return Column(
                    children: [
                      if (_index!=0) 
                        Padding(
                          padding: const EdgeInsets.only(top:12.0),
                          child: Container(
                            color: Colors.black45,
                            height: 0.5,
                            width: double.infinity,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top:16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tiết ${_tempClass.start} "
                                "- ${_tempClass.end}: "
                                "${_tempClass.subjectName}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.alarm, size: 12, color: AppColor.red,),
                                    ),
                                    Column(
                                      children: [
                                        Text("${_tempClass.startAt.substring(0,5)} - ${_tempClass.endAt.substring(0,5)}",
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(height: 3,),
                                        Text("${dateFormat.format(_tempClass.date)}",
                                          style: const TextStyle(fontSize: 13)
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.location_on_rounded, size: 12, color: Colors.blue[800],),
                                    ),
                                    Text("Phòng: ${_tempClass.classroom}",
                                      style: const TextStyle(fontSize: 13)
                                    )
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            const Icon(Icons.arrow_forward_ios, size: 16,)
                          ],
                        ),
                      ),
                    ],
                  );
                })
              )
            ],
          ),
        ),
      );
      },
    );
  }
}

class TempClass {
  final Schedule schedule;
  final int start;
  final int end;
  final String startAt;
  final String endAt;
  final DateTime date;
  final String classroom;
  final String subjectName;

  const TempClass(this.schedule, this.start, this.end, this.startAt, this.endAt, this.date,
      this.classroom, this.subjectName);
}
