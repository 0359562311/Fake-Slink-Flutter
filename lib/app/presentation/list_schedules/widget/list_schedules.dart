import 'package:fakeslink/app/presentation/list_schedules/bloc/list_schedules_bloc.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ListSchedule extends StatefulWidget {
  const ListSchedule({Key? key}) : super(key: key);

  @override
  _ListScheduleState createState() => _ListScheduleState();
}

class _ListScheduleState extends State<ListSchedule> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  late final ListScheduleBloc _bloc;
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  late int _month;
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _focusedDate = _selectedDate = DateTime.now();
    _bloc = ListScheduleBloc()..add(ListScheduleInitEvent(_selectedDate));
    _month = _selectedDate.month;
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Thời khoá biểu", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: AppColor.red,
        ),
        body: BlocConsumer<ListScheduleBloc, ListScheduleState>(
          bloc: _bloc,
          listener: (context, state) {},
          listenWhen: (previous, next) => next is ListScheduleErrorState,
          builder: (context, state) {
            if (state is ListScheduleLoadingState)
              return Center(
                child: CircularProgressIndicator(),
              );
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _calendar(state as ListScheduleSuccessfulState),
                    SizedBox(
                      height: 16,
                    ),
                    ..._item(state)
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _calendar(ListScheduleSuccessfulState state) {
    return TableCalendar(
      locale: 'vi_VN',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDate,
      calendarFormat: _calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.monday,
      onFormatChanged: (f) {},
      onDaySelected: (selected, focused) {
        if (!isSameDay(_selectedDate, selected)) {
          setState(() {
            _selectedDate = selected;
          });
        }
      },
      eventLoader: (dateTime) {
        return state.items[_formatter.format(dateTime)] ?? [];
      },
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration:
            BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
        selectedTextStyle: TextStyle(color: Colors.white),
        todayDecoration:
            BoxDecoration(color: AppColor.red, shape: BoxShape.circle),
        canMarkersOverflow: true,
        outsideDaysVisible: false,
      ),
      onPageChanged: (date) {
        if (date.month != _month) {
          if (date.month != DateTime.now().month)
            _selectedDate = _focusedDate = date;
          else
            _selectedDate = _focusedDate = DateTime.now();
          _month = date.month;
          _bloc.add(ListScheduleMonthChangeEvent(date));
        }
      },
      headerStyle: HeaderStyle(formatButtonVisible: false),
      selectedDayPredicate: (date) {
        return isSameDay(_selectedDate, date);
      },
      calendarBuilders:
          CalendarBuilders(markerBuilder: (context, date, events) {
        if (events.isEmpty) return null;
        return Container(
          height: 5,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: AppColor.red, borderRadius: BorderRadius.circular(2)),
        );
      }),
    );
  }

  List<Widget> _item(ListScheduleSuccessfulState state) {
    return List.generate(
        (state.items[_formatter.format(_selectedDate)] ?? []).length, (index) {
      final _item = state.items[_formatter.format(_selectedDate)]![index];
      return Column(
        children: [
          if (index != 0)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                color: Colors.black45,
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
                      "Tiết ${_item.start} "
                      "- ${_item.end}: "
                      "${_item.subjectName}",
                      style: const TextStyle(fontSize: 13),
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
                            color: AppColor.red,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "${_item.startAt.substring(0, 5)} - ${_item.endAt.substring(0, 5)}",
                              style: const TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text("${_formatter.format(_item.date)}",
                                style: const TextStyle(fontSize: 13))
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
                        Text("Phòng: ${_item.classroom}",
                            style: const TextStyle(fontSize: 13))
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
      );
    });
  }
}
