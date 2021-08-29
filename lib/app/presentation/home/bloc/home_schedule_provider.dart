import 'package:dio/dio.dart';
import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_schedule_use_case.dart';
import 'package:fakeslink/app/presentation/home/ui/home_schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HomeScheduleProvider extends ChangeNotifier {
  late GetListScheduleUseCase _getListScheduleUseCase;

  late List<Schedule> _schedules;
  late DateTime initDate;

  List<List<TempClass>> _tempClasses = [];

  List<List<TempClass>> get tempClasses => _tempClasses;

  HomeScheduleProvider(){
    _getListScheduleUseCase = GetIt.instance<GetListScheduleUseCase>();
    init();
  }

  Future<void> init() async{
    try {
      initDate = DateTime.now();
      int week = initDate.difference(GetIt.instance<Semester>().startAt).inDays~/7 + 1;
      _schedules = await _getListScheduleUseCase.execute();
      for (int i = 0; i < 3; i++) {
        final temp = _schedules.where((element) => 
          element.dayOfWeek == ((i + initDate.weekday) <=7 ? i + initDate.weekday : i + initDate.weekday - 7) 
          && element.weeks.contains(week)
        ).toList();
        temp.sort((a,b){
          return a.startAt.compareTo(b.startAt);
        });
        _tempClasses.add(temp.map((e) => TempClass(
          e, 
          _getStart(e.startAt), 
          _getEnd(e.endAt), 
          e.startAt, 
          e.endAt, 
          GetIt.instance<Semester>().startAt.add(Duration(days: 7*(week-1) + e.dayOfWeek - 1)), 
          e.classroom,
          e.registerableClass.subject.subjectName
        )).toList());
      }
      notifyListeners();
    } on DioError catch (e) {
      // TODO
    }
  }



  int _getStart(String startAt) {
    int hours = int.parse(startAt.substring(0,2));
    switch(hours){
      case 7: return 1;
      case 9: return 2;
      case 12: return 3;
      case 14: return 4;
      case 16: return 5;
      case 18: return 6;
      default: return 6;
    }
  }

  int _getEnd(String endAt) {
    int hours = int.parse(endAt.substring(3,5));
    switch(hours){
      case 9: return 1;
      case 11: return 2;
      case 14: return 3;
      case 16: return 4;
      case 18: return 5;
      case 20: return 6;
      default: return 6;
    }
  }

}