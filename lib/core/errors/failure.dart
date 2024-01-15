abstract class Failure {
  final String errorMsg;
  const Failure({required this.errorMsg});
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMsg}) : super(errorMsg: errorMsg);
}

class CacheFailure extends Failure {
  CacheFailure({required String errorMsg}) : super(errorMsg: errorMsg);
}
