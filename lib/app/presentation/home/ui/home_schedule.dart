import 'package:fakeslink/app/domain/entities/schedule_item.dart';
import 'package:fakeslink/app/presentation/home/bloc/home_schedule_provider.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeSchedule extends StatefulWidget {
  const HomeSchedule({Key? key}) : super(key: key);

  @override
  _HomeScheduleState createState() => _HomeScheduleState();
}

class _HomeScheduleState extends State<HomeSchedule> {
  int index = 0;

  late HomeScheduleProvider _provider;

  @override
  void initState() {
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
                    _HeaderItem(
                        index: 0,
                        currentIndex: index,
                        title: "Hôm nay",
                        callback: () {
                          if (index != 0)
                            setState(() {
                              index = 0;
                            });
                        }),
                    _HeaderItem(
                        index: 1,
                        currentIndex: index,
                        title: "Ngày mai",
                        callback: () {
                          if (index != 1)
                            setState(() {
                              index = 1;
                            });
                        }),
                    _HeaderItem(
                        index: 2,
                        currentIndex: index,
                        title: "Ngày kia",
                        callback: () {
                          if (index != 2)
                            setState(() {
                              index = 2;
                            });
                        }),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                (_provider.scheduleItems.length == 0)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: CircularProgressIndicator(
                          color: AppColor.black,
                          strokeWidth: 5,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _provider.scheduleItems[index].length == 0
                            ? [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                      "Không có lịch học",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    ))
                              ]
                            : List.generate(
                                _provider.scheduleItems[index].length,
                                (_index) {
                                final _tempClass =
                                    _provider.scheduleItems[index][_index];
                                return _BodyItem(
                                  index: _index,
                                  callback: () {
                                    Navigator.pushNamed(context,
                                        AppRoute.registerableClassDetails,
                                        arguments: _tempClass
                                            .schedule.registerableClass.id);
                                  },
                                  tempClass: _tempClass,
                                );
                              }))
              ],
            ),
          ),
        );
      },
    );
  }
}
class _HeaderItem extends StatefulWidget {
  final String title;
  final int index;
  final int currentIndex;
  final Function() callback;
  const _HeaderItem(
      {Key? key,
      required this.index,
      required this.currentIndex,
      required this.title,
      required this.callback})
      : super(key: key);

  @override
  _HeaderItemState createState() => _HeaderItemState();
}

class _HeaderItemState extends State<_HeaderItem> {
  double _opacity = 1;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          _opacity = 0.5;
        });
        Future.delayed(Duration(milliseconds: 200)).whenComplete(() {
          widget.callback();
          setState(() {
            _opacity = 1;
          });
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
            color: _getColor((widget.index == widget.currentIndex
                ? Colors.black87
                : Colors.white)),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          style: TextStyle(
              color: _getColor((widget.index == widget.currentIndex
                  ? Colors.white
                  : Colors.black87)),
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
      ),
    );
  }

  Color _getColor(Color color) {
    if (_opacity == 1) return color;
    return color.withOpacity(_opacity);
  }
}

class _BodyItem extends StatefulWidget {
  final ScheduleItem tempClass;
  final int index;
  final Function() callback;
  const _BodyItem(
      {Key? key,
      required this.tempClass,
      required this.index,
      required this.callback})
      : super(key: key);

  @override
  _BodyItemState createState() => _BodyItemState();
}

class _BodyItemState extends State<_BodyItem> {
  final DateFormat _dateFormat = DateFormat("dd/MM/yyyy");
  double _opacity = 1;

  Color _getColor(Color color) {
    if (_opacity == 1) return color;
    return color.withOpacity(_opacity);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          _opacity = 0.5;
        });
        Future.delayed(Duration(milliseconds: 200)).whenComplete(() {
          widget.callback();
          setState(() {
            _opacity = 1;
          });
        });
      },
      child: Column(
        children: [
          if (widget.index != 0)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                color: _getColor(Colors.black45),
                height: 0.5,
                width: double.infinity,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tiết ${widget.tempClass.start} "
                      "- ${widget.tempClass.end}: "
                      "${widget.tempClass.subjectName}",
                      style: TextStyle(
                          fontSize: 13, color: _getColor(Colors.black87)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.alarm,
                            size: 12,
                            color: _getColor(AppColor.red),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "${widget.tempClass.startAt.substring(0, 5)} - ${widget.tempClass.endAt.substring(0, 5)}",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: _getColor(Colors.black87)),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${_dateFormat.format(widget.tempClass.date)}",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: _getColor(Colors.black87)),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.location_on_rounded,
                            size: 12,
                            color: Colors.blue[800],
                          ),
                        ),
                        Text(
                          "Phòng: ${widget.tempClass.classroom}",
                          style: TextStyle(
                              fontSize: 13, color: _getColor(Colors.black87)),
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
