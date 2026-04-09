import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/raw_materials/model/raw_material_model.dart';
import 'package:raw_chem/features/categories/repo/categories_repo.dart';

class CategoryMaterialsCubit extends Cubit<BaseState<RawMaterialModel>> {
  final CategoriesRepo _categoriesRepo;
  late final PaginationHandler<RawMaterialModel, CategoryMaterialsCubit> paginationHandler;
  
  int? categoryId;

  CategoryMaterialsCubit(this._categoriesRepo) : super(const BaseState<RawMaterialModel>()) {
    paginationHandler = PaginationHandler<RawMaterialModel, CategoryMaterialsCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> fetchItems(int id) async {
    categoryId = id;
    await paginationHandler.loadFirstPage((page, limit, [params]) => 
      _categoriesRepo.getCategoryMaterials(categoryId: categoryId!, page: page));
  }

  Future<void> loadMore() async {
    if (categoryId == null) return;
    await paginationHandler.fetchData((page, limit, [params]) => 
      _categoriesRepo.getCategoryMaterials(categoryId: categoryId!, page: page));
  }
}
