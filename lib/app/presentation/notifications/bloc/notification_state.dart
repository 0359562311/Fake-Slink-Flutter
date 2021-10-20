abstract class NotificationState {
  final String type;
  const NotificationState(this.type);
}

class NotificationLoadingState extends NotificationState {
  const NotificationLoadingState(String type) : super(type);

  bool equals(NotificationLoadingState other) {
    return other.type == this.type;
  }
}

class NotificationSuccessfulState extends NotificationState {
  const NotificationSuccessfulState(String type) : super(type);
}

class NotificationErrorState extends NotificationState {
  final String message;
  NotificationErrorState(String type, this.message) : super(type);
}
