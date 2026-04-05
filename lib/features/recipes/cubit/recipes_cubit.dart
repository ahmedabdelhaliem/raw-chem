import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/recipes/model/recipe_model.dart';
import 'package:raw_chem/features/recipes/repo/recipes_repo.dart';

class RecipesCubit extends Cubit<BaseState<RecipeModel>> {
  final RecipesRepo _recipesRepo;
  late final PaginationHandler<RecipeModel, RecipesCubit> paginationHandler;

  RecipesCubit(this._recipesRepo) : super(const BaseState<RecipeModel>()) {
    paginationHandler = PaginationHandler<RecipeModel, RecipesCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> fetchRecipes() async {
    await paginationHandler.loadFirstPage((page, limit, [params]) => _recipesRepo.getRecipes(page: page));
  }

  Future<void> loadMore() async {
    await paginationHandler.fetchData((page, limit, [params]) => _recipesRepo.getRecipes(page: page));
  }
}
