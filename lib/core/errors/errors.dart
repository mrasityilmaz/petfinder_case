// ignore_for_file: overridden_fields

import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure([this.properties = const <dynamic>[], this.errorMessage = 'Something went wrong']);
  final List<Object?> properties;
  final String? errorMessage;

  @override
  List<Object?> get props => properties;
}

// General failures
final class NetworkFailure extends Failure {
  NetworkFailure(this.errorMessage) : super([errorMessage]);
  @override
  final String? errorMessage;
}

final class ServerFailure extends Failure {
  ServerFailure({this.errorMessage}) : super([errorMessage]);
  @override
  final String? errorMessage;
}

final class CacheFailure extends Failure {
  CacheFailure({this.errorMessage}) : super([errorMessage]);
  @override
  final String? errorMessage;
}

final class UnExpectedFailure<T> extends Failure {
  UnExpectedFailure({this.errorMessage, this.data}) : super([errorMessage, data]);
  @override
  final String? errorMessage;
  final T? data;
}
