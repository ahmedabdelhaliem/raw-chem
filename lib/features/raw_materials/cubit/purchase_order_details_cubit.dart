import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/profile/model/purchase_order/purchase_order_model.dart';
import 'package:raw_chem/features/raw_materials/repo/raw_materials_repo.dart';

class PurchaseOrderDetailsCubit extends Cubit<BaseState<PurchaseOrderModel>> {
  final RawMaterialsRepo _repo;

  PurchaseOrderDetailsCubit(this._repo) : super(const BaseState<PurchaseOrderModel>());

  Future<void> getPurchaseOrderDetails(int id) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _repo.getPurchaseOrderDetails(id);

    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
      )),
      (order) => emit(state.copyWith(
        status: Status.success,
        data: order,
      )),
    );
  }
}
