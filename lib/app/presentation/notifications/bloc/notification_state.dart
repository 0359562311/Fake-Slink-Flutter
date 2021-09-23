abstract class NotificationState {
  const NotificationState();
}

class NotificationLoadingState extends NotificationState {
  final String type;
  const NotificationLoadingState(this.type);
}
class NotificationSuccessfulState extends NotificationState {
  String type;
  NotificationSuccessfulState(this.type);
}

class NotificationErrorState extends NotificationState {
  final String message;
  const NotificationErrorState(this.message);
}