abstract class Failure {
  final String message;

  const Failure(this.message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class APIFailure extends Failure {
  const APIFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("Kiểm tra kết nối internet");
}
