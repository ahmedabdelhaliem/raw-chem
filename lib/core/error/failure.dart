abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message);
}

class ParsingFailure extends Failure {
  const ParsingFailure({required String message}) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure({required String message}) : super(message);
}
