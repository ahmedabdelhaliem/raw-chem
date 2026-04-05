import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import '../http/either.dart';
import '../http/failure.dart';
import '../model/paginated_response.dart';

typedef PaginatedFunc<T> = Future<Either<Failure, PaginatedResponse<T>>>
    Function(int page, int limit, [Map<String, dynamic>? params]);

class PaginationHandler<T, B extends BlocBase<BaseState<T>>> {
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int currentPage = 1;
  int lastPage = 1;
  final int pageSize;
  List<T> items = [];
  final B bloc;
  final String? cacheKey;

  PaginationHandler({
    required this.bloc,
    this.cacheKey,
    this.pageSize = 15,
  });

  Future<void> loadFirstPage(PaginatedFunc<T> fetchFunction,
      {Map<String, dynamic>? params}) async {
    bloc.emit(bloc.state.copyWith(status: Status.loading));
    items.clear();
    currentPage = 1;
    isLoadingMore = false;
    hasMoreData = true;

    final result = await fetchFunction(currentPage, pageSize, params);
    await result.fold((failure) async {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      bloc.emit(bloc.state.copyWith(
          status: Status.error,
          failure: failure,
          errorMessage: failure.message));
    }, (response) async {
      items.addAll(response.data);
      currentPage = (response.pagination.currentPage ?? 1) + 1;
      lastPage = response.pagination.lastPage ?? 1;
      hasMoreData = (response.pagination.currentPage ?? 1) <
          (response.pagination.lastPage ?? 1);

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      bloc.emit(bloc.state
          .copyWith(status: Status.success, items: List<T>.from(items)));
    });
  }

  Future<void> fetchData(PaginatedFunc<T> fetchFunction,
      {Map<String, dynamic>? params}) async {
    if (!hasMoreData || isLoadingMore) {
      log("Pagination: No more data or already loading... hasMoreData: $hasMoreData, isLoadingMore: $isLoadingMore");
      return;
    }

    isLoadingMore = true;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    bloc.emit(bloc.state.copyWith(status: Status.isPaginationLoading));

    final result = await fetchFunction(currentPage, pageSize,
        params?..removeWhere((key, value) => value == null || value == ''));

    await result.fold(
      (failure) async {
        isLoadingMore = false;
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        bloc.emit(bloc.state.copyWith(
            status: Status.isPaginationFailure,
            failure: failure,
            errorMessage: failure.message));
      },
      (response) async {
        items.addAll(response.data);
        currentPage = (response.pagination.currentPage ?? currentPage) + 1;
        lastPage = response.pagination.lastPage ?? lastPage;
        hasMoreData = (response.pagination.currentPage ?? 1) <
            (response.pagination.lastPage ?? 1);

        isLoadingMore = false;
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        bloc.emit(bloc.state
            .copyWith(status: Status.success, items: List<T>.from(items)));
      },
    );
  }
}
