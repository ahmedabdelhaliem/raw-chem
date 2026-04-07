import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/common/http/pagination_helper.dart';
import 'package:raw_chem/features/recipes/model/recipe_model.dart';
import 'package:raw_chem/features/recipes/repo/recipes_repo.dart';

class RecipesCubit extends Cubit<BaseState<RecipeModel>> {
  final RecipesRepo _recipesRepo;
  late final PaginationHandler<RecipeModel, RecipesCubit> paginationHandler;
  List<int> selectedTypes = [];
  String searchQuery = '';

  RecipesCubit(this._recipesRepo) : super(const BaseState<RecipeModel>()) {
    paginationHandler = PaginationHandler<RecipeModel, RecipesCubit>(
      bloc: this,
      pageSize: 10,
    );
  }

  Future<void> fetchRecipes({List<int>? types, String? query}) async {
    if (types != null) {
      selectedTypes = types;
    }
    if (query != null) {
      searchQuery = query;
    }
    await paginationHandler.loadFirstPage((page, limit, [params]) => 
      _recipesRepo.getRecipes(page: page, types: selectedTypes, q: searchQuery));
  }

  Future<void> loadMore() async {
    await paginationHandler.fetchData((page, limit, [params]) => 
      _recipesRepo.getRecipes(page: page, types: selectedTypes, q: searchQuery));
  }
}

