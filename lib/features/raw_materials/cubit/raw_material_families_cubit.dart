import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/raw_materials/model/raw_material_model.dart';
import 'package:raw_chem/features/raw_materials/repo/raw_materials_repo.dart';

class RawMaterialFamiliesCubit extends Cubit<BaseState<MaterialFamilyModel>> {
  final RawMaterialsRepo _materialsRepo;

  RawMaterialFamiliesCubit(this._materialsRepo) : super(const BaseState<MaterialFamilyModel>()) {
    fetchFamilies();
  }

  Future<void> fetchFamilies() async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));
    final result = await _materialsRepo.getMaterialFamilies();
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
      )),
      (families) => emit(state.copyWith(
        status: Status.success,
        items: families,
      )),
    );
  }
}
