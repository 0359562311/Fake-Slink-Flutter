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