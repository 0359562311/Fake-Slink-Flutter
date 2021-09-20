import 'package:fakeslink/app/domain/entities/schedule.dart';
import 'package:fakeslink/app/domain/entities/schedule_item.dart';
import 'package:fakeslink/app/domain/entities/semester.dart';
import 'package:fakeslink/app/domain/use_cases/get_list_schedule_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ListScheduleBloc extends Bloc<ListScheduleEvent, ListScheduleState>{
  late final GetListScheduleUseCase _getListScheduleUseCase;
  ListScheduleBloc() : super(ListScheduleLoadingState()) {
    _getListScheduleUseCase = GetIt.instance<GetListScheduleUseCase>();
  }
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  List<Schedule> _schedules = [];

  @override
  Stream<ListScheduleState> mapEventToState(ListScheduleEvent event) async* {
    if (event is ListScheduleInitEvent) {
      yield ListScheduleLoadingState();
      _schedules = await _getListScheduleUseCase.execute();
      yield* _getMapScheduleItems(event.dateTime);
    } else if (event is ListScheduleMonthChangeEvent) {
      yield* _getMapScheduleItems(event.dateTime);
    }
  }

  Stream<ListScheduleState> _getMapScheduleItems(DateTime d) async* {
    int month = d.month;
    DateTime startSemester = GetIt.instance<Semester>().startAt;
    Map<String,List<ScheduleItem>> res = {};
    _schedules.forEach((schedule) { 
      for(int i = 0; ; i++) {
        DateTime current = startSemester.add(Duration(days: schedule.dayOfWeek-1 + i));
        if(current.month < month) continue;
        else if(current.month > month) break;
        Duration d = current.difference(startSemester.add(Duration(days: schedule.dayOfWeek-1)));
        if(d.inDays%7 == 0 && schedule.weeks.contains(d.inDays~/7)) {
          String key = _formatter.format(current);
          if(!res.containsKey(key))
            res[key] = [];
          res[key]?.add(ScheduleItem(schedule, _getStart(schedule.startAt),_getEnd(schedule.endAt),
            schedule.startAt, schedule.endAt, current, schedule.classroom, schedule.registerableClass.subject.subjectName
          ));
        }
      }
    });
    yield ListScheduleSuccessfulState(res);
  }

  int _getStart(String startAt) {
    int hours = int.parse(startAt.substring(0,2));
    switch(hours){
      case 7: return 1;
      case 9: return 3;
      case 12: return 5;
      case 14: return 7;
      case 16: return 9;
      case 18: return 11;
      default: return 11;
    }
  }

  int _getEnd(String endAt) {
    int hours = int.parse(endAt.substring(0,2));
    switch(hours){
      case 8:
      case 9: return 2;
      case 10:
      case 11: return 4;
      case 13:
      case 14: return 6;
      case 15:
      case 16: return 8;
      case 17:
      case 18: return 10;
      case 19:
      case 20: return 12;
      default: return 12;
    }
  }
}

abstract class ListScheduleEvent{
  const ListScheduleEvent();
}

class ListScheduleInitEvent extends ListScheduleEvent {
  final DateTime dateTime;
  const ListScheduleInitEvent(this.dateTime);
}

class ListScheduleMonthChangeEvent extends  ListScheduleEvent {
  final DateTime dateTime;
  const ListScheduleMonthChangeEvent(this.dateTime);
}

abstract class ListScheduleState{
  const ListScheduleState();
}

class ListScheduleLoadingState extends ListScheduleState {
  const ListScheduleLoadingState();
}

class ListScheduleSuccessfulState extends ListScheduleState {
  final Map<String,List<ScheduleItem>> items;
  const ListScheduleSuccessfulState(this.items);
}

class ListScheduleErrorState extends ListScheduleState {
  final String message;
  const ListScheduleErrorState(this.message);
}