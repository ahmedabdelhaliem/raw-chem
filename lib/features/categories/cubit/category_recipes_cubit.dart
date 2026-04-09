import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/recipes/model/recipe_model.dart';
import 'package:raw_chem/features/categories/repo/categories_repo.dart';

class CategoryRecipesCubit extends Cubit<BaseState<RecipeModel>> {
  final CategoriesRepo _categoriesRepo;
  late final PaginationHandler<RecipeModel, CategoryRecipesCubit> paginationHandler;
  
  int? categoryId;

  CategoryRecipesCubit(this._categoriesRepo) : super(const BaseState<RecipeModel>()) {
    paginationHandler = PaginationHandler<RecipeModel, CategoryRecipesCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> fetchItems(int id) async {
    categoryId = id;
    await paginationHandler.loadFirstPage((page, limit, [params]) => 
      _categoriesRepo.getCategoryRecipes(categoryId: categoryId!, page: page));
  }

  Future<void> loadMore() async {
    if (categoryId == null) return;
    await paginationHandler.fetchData((page, limit, [params]) => 
      _categoriesRepo.getCategoryRecipes(categoryId: categoryId!, page: page));
  }
}
