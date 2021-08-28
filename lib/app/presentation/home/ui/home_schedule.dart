import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeSchedule extends StatefulWidget {
  const HomeSchedule({Key? key}) : super(key: key);

  @override
  _HomeScheduleState createState() => _HomeScheduleState();
}

class _HomeScheduleState extends State<HomeSchedule> {
  List<TempClass> _tempClasses = [
    TempClass(7, 8, TimeOfDay(hour: 14, minute: 30),
        TimeOfDay(hour: 16, minute: 20), DateTime.now(), "1109606"),
    TempClass(9, 10, TimeOfDay(hour: 16, minute: 30),
        TimeOfDay(hour: 18, minute: 20), DateTime.now(), "70239"),
    TempClass(11, 12, TimeOfDay(hour: 19, minute: 30),
        TimeOfDay(hour: 21, minute: 20), DateTime.now(), "1109606"),
  ];
  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    "Hom nay",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    "Ngay mai",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    "Ngay kia",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(_tempClasses.length, (index){
                return Column(
                  children: [
                    if (index!=0) 
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
                              Text("Tiết ${_tempClasses[index].start} - ${_tempClasses[index].end}: lap trinh as bfjdn s",
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
                                      Text("${_tempClasses[index].startAt.format(context)} - ${_tempClasses[index].endAt.format(context)}",
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(height: 3,),
                                      Text("${dateFormat.format(_tempClasses[index].date)}",
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
                                  Text("Phòng: ${_tempClasses[index].classroom}",
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
  }
}

class TempClass {
  final int start;
  final int end;
  final TimeOfDay startAt;
  final TimeOfDay endAt;
  final DateTime date;
  final String classroom;

  const TempClass(this.start, this.end, this.startAt, this.endAt, this.date,
      this.classroom);
}
