import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/recipes/model/recipe_model.dart';
import 'package:raw_chem/features/recipes/repo/recipes_repo.dart';

class RecipeDetailsCubit extends Cubit<BaseState<RecipeModel>> {
  final RecipesRepo _recipesRepo;

  RecipeDetailsCubit(this._recipesRepo) : super(const BaseState<RecipeModel>());

  Future<void> getRecipeDetails(int id) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _recipesRepo.getRecipeDetails(id);

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
