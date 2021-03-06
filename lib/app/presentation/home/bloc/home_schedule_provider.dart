import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/entities/schedule_item.dart';
import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_schedule_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HomeScheduleProvider extends ChangeNotifier {
  late GetListScheduleUseCase _getListScheduleUseCase;

  late List<Schedule> _schedules;
  late DateTime initDate;

  List<List<ScheduleItem>> _scheduleItems = [];

  List<List<ScheduleItem>> get scheduleItems => _scheduleItems;

  HomeScheduleProvider() {
    _getListScheduleUseCase = GetIt.instance<GetListScheduleUseCase>();
    init();
  }

  Future<void> init() async {
    initDate = DateTime.now();
    final res = await _getListScheduleUseCase.execute();
    if (res.isSuccess()) {
      _schedules = res.getSuccess()!;
      createListSchedule();
    }
  }

  void createListSchedule() {
    int week =
        initDate.difference(GetIt.instance<Semester>().startAt).inDays ~/ 7 + 1;
    for (int i = 0; i < 3; i++) {
      final temp = _schedules
          .where((element) =>
              element.dayOfWeek ==
                  ((i + initDate.weekday) <= 7
                      ? i + initDate.weekday
                      : i + initDate.weekday - 7) &&
              element.weeks.contains(week))
          .toList();
      temp.sort((a, b) {
        return a.startAt.compareTo(b.startAt);
      });
      _scheduleItems.add(temp
          .map((e) => ScheduleItem(
              e,
              _getStart(e.startAt),
              _getEnd(e.endAt),
              e.startAt,
              e.endAt,
              GetIt.instance<Semester>()
                  .startAt
                  .add(Duration(days: 7 * (week - 1) + e.dayOfWeek - 1)),
              e.classroom,
              e.registerableClass.subject.subjectName))
          .toList());
    }
    notifyListeners();
  }

  int _getStart(String startAt) {
    int hours = int.parse(startAt.substring(0, 2));
    switch (hours) {
      case 7:
        return 1;
      case 9:
        return 3;
      case 12:
        return 5;
      case 14:
        return 7;
      case 16:
        return 9;
      case 18:
        return 11;
      default:
        return 11;
    }
  }

  int _getEnd(String endAt) {
    int hours = int.parse(endAt.substring(0, 2));
    switch (hours) {
      case 8:
      case 9:
        return 2;
      case 10:
      case 11:
        return 4;
      case 13:
      case 14:
        return 6;
      case 15:
      case 16:
        return 8;
      case 17:
      case 18:
        return 10;
      case 19:
      case 20:
        return 12;
      default:
        return 12;
    }
  }
}
