import 'package:equatable/equatable.dart';

enum Status { initial, loading, success, error }

class BaseState<T> extends Equatable {
  final Status status;
  final T? data;
  final String? errorMessage;

  const BaseState({
    this.status = Status.initial,
    this.data,
    this.errorMessage,
  });

  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;

  BaseState<T> copyWith({
    Status? status,
    T? data,
    String? errorMessage,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
