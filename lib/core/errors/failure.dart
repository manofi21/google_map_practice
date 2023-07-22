import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  String toString() => message;

  @override
  List<Object> get props => [];
}

class NoMessageFailure extends Failure {
  const NoMessageFailure() : super("");
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}

class DeviceLocationRepoFailure extends Failure {
  const DeviceLocationRepoFailure(String message) : super(message);
}