import 'package:fakeslink/app/domain/entities/schedule_item.dart';

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