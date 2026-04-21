import 'package:equatable/equatable.dart';
import '../../common/http/failure.dart';

enum Status {
  initial,
  loading,
  success,
  error,
  unverifiedAccount,
  isLoadingMore,
  isPaginationLoading,
  isPaginationFailure,
  custom,
}

enum ResendStatus { idle, loading, success, error }

extension BaseStateX<T> on BaseState<T> {
  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
  bool get isFailure => status == Status.error; // Alias for compatibility
  bool get isUnverifiedAccount => status == Status.unverifiedAccount;
  bool get isLoadingMore => status == Status.isLoadingMore;
  bool get isPaginationLoading => status == Status.isPaginationLoading;
  bool get isPaginationFailure => status == Status.isPaginationFailure;
  bool get isCustom => status == Status.custom;

  bool get isEmpty => isSuccess && items.isEmpty;
  bool get hasData => data != null;
  bool get hasItems => items.isNotEmpty;
}

class BaseState<T> extends Equatable {
  final Status status;
  final T? data;
  final List<T> items;
  final Map<String, dynamic> metadata;
  final String? errorMessage;
  final String? message;
  final Failure? failure;
  final bool hasMore;
  final ResendStatus? resendStatus;
  final String? resendError;

  const BaseState({
    this.status = Status.initial,
    this.data,
    this.items = const [],
    this.metadata = const {},
    this.errorMessage,
    this.message,
    this.failure,
    this.hasMore = false,
    this.resendStatus,
    this.resendError,
  });

  BaseState<T> copyWith({
    Status? status,
    T? data,
    List<T>? items,
    Map<String, dynamic>? metadata,
    String? errorMessage,
    String? message,
    Failure? failure,
    bool? hasMore,
    ResendStatus? resendStatus,
    String? resendError,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      items: items ?? this.items,
      metadata: metadata ?? this.metadata,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      failure: failure ?? this.failure,
      hasMore: hasMore ?? this.hasMore,
      resendStatus: resendStatus ?? this.resendStatus,
      resendError: resendError ?? this.resendError,
    );
  }

  @override
  List<Object?> get props => [status, data, items, metadata, errorMessage, message, failure, hasMore, resendStatus, resendError];
}
