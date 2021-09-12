abstract class ResultState {
  const ResultState();
}

class ResultLoadingState extends ResultState {
  const ResultLoadingState();
}

class ResultErrorState extends ResultState {
  final String message;
  const ResultErrorState(this.message);
}

class ResultSuccessfulState extends ResultState {}