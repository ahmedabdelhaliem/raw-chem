import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/raw_materials/repo/raw_materials_repo.dart';

class CreatePurchaseOrderCubit extends Cubit<BaseState<dynamic>> {
  final RawMaterialsRepo _repo;

  CreatePurchaseOrderCubit(this._repo) : super(const BaseState<dynamic>());

  Future<void> createPurchaseOrder({
    required int materialId,
    required double quantity,
    required int countryId,
    required int governorateId,
    required int cityId,
    required String distinguishingMark,
    required String recipientPhone,
  }) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _repo.createPurchaseOrder(
      materialId: materialId,
      quantity: quantity,
      countryId: countryId,
      governorateId: governorateId,
      cityId: cityId,
      distinguishingMark: distinguishingMark,
      recipientPhone: recipientPhone,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: Status.success,
        data: response,
      )),
    );
  }
}
