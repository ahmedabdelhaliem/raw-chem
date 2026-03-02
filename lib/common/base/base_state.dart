import 'exports.dart';

enum Status {
  initial,
  loading,
  success,
  failure,
  isLoadingMore, // Loader عادي أثناء العمليات
  custom,
  isPaginationLoading, // Loader أثناء تحميل الصفحات التالية
  isPaginationFailure, // فشل تحميل الصفحات التالية
}

extension BaseStateX<T> on BaseState<T> {
  bool get isInitial => status == Status.initial;

  bool get isLoading => status == Status.loading;

  bool get isSuccess => status == Status.success;

  bool get isFailure => status == Status.failure;

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
  final String? errorMessage;
  final String? message;
  final T? data;
  final List<T> items;
  final Map<String, dynamic> metadata;
  final Failure? failure;

  const BaseState({
    this.status = Status.initial,
    this.failure,
    this.errorMessage,
    this.message,
    this.data,
    this.items = const [],
    this.metadata = const {},
  });

  BaseState<T> copyWith({
    Status? status,
    String? errorMessage,
    Failure? failure,
    T? data,
    List<T>? items,
    Map<String, dynamic>? metadata,
    String? message,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      data: data ?? this.data,
      items: items ?? this.items,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, data, items, metadata, failure, message];
}
