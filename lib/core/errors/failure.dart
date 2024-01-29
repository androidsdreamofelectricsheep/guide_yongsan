import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMsg;
  const Failure({required this.errorMsg});
}

class ServerFailure extends Failure {
  const ServerFailure({required String errorMsg}) : super(errorMsg: errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}

class CacheFailure extends Failure {
  const CacheFailure({required String errorMsg}) : super(errorMsg: errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
