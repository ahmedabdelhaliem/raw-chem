import 'package:raw_chem/app/imports.dart';

class PurchaseOrdersHistoryCubit extends Cubit<BaseState<PaginatedResponse<PurchaseOrderModel>>> {
  final RawMaterialsRepo _repo;

  PurchaseOrdersHistoryCubit(this._repo) : super(const BaseState<PaginatedResponse<PurchaseOrderModel>>());

  Future<void> getPurchaseOrders({required dynamic status, int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(status: Status.loading));
    }

    final result = await _repo.getPurchaseOrders(page: page, status: status);

    result.fold(
      (failure) => emit(state.copyWith(status: Status.error, errorMessage: failure.message)),
      (response) {
        if (page == 1) {
          emit(state.copyWith(status: Status.success, data: response));
        } else {
          // Append data for pagination
          final currentData = state.data?.data ?? [];
          final newData = response.data;
          emit(state.copyWith(
            status: Status.success,
            data: PaginatedResponse(
              data: [...currentData, ...newData],
              pagination: response.pagination,
            ),
          ));
        }
      },
    );
  }
}
