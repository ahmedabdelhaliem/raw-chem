import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/raw_materials/model/raw_material_model.dart';
import 'package:raw_chem/features/raw_materials/repo/raw_materials_repo.dart';

class RawMaterialDetailsCubit extends Cubit<BaseState<RawMaterialModel>> {
  final RawMaterialsRepo _materialsRepo;

  RawMaterialDetailsCubit(this._materialsRepo) : super(const BaseState<RawMaterialModel>());

  Future<void> getMaterialDetails(int id) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _materialsRepo.getMaterialDetails(id);

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
