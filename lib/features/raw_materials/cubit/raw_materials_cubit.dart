import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/raw_materials/model/raw_material_model.dart';
import 'package:raw_chem/features/raw_materials/repo/raw_materials_repo.dart';

class RawMaterialsCubit extends Cubit<BaseState<RawMaterialModel>> {
  final RawMaterialsRepo _materialsRepo;
  late final PaginationHandler<RawMaterialModel, RawMaterialsCubit> paginationHandler;

  RawMaterialsCubit(this._materialsRepo) : super(const BaseState<RawMaterialModel>()) {
    paginationHandler = PaginationHandler<RawMaterialModel, RawMaterialsCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> fetchMaterials() async {
    await paginationHandler.loadFirstPage((page, limit, [params]) => _materialsRepo.getMaterials(page: page));
  }

  Future<void> loadMore() async {
    await paginationHandler.fetchData((page, limit, [params]) => _materialsRepo.getMaterials(page: page));
  }
}
