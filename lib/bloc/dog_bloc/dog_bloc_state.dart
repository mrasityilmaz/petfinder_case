part of 'dog_bloc.dart';

abstract class DogBlocState extends Equatable {}

final class InitialState extends DogBlocState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends DogBlocState {
  @override
  List<Object> get props => [];
}

final class SuccessState<T, R> extends DogBlocState {
  SuccessState({required this.data});

  final R data;
  @override
  List<dynamic> get props => [data];
}

final class ChangeSourceState<T> extends DogBlocState {
  ChangeSourceState({required this.data});

  final T data;
  @override
  List<dynamic> get props => [data];
}

final class FailureState<Failure> extends DogBlocState {
  FailureState({required this.failure});

  final Failure failure;
  @override
  List<dynamic> get props => [failure];
}
