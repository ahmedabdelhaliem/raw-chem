import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/core/state/base_state.dart';
import 'package:raw_chem/features/categories/model/category_model.dart';
import 'package:raw_chem/features/recipes/repo/recipes_repo.dart';

class RecipeTypesCubit extends Cubit<BaseState<CategoryModel>> {
  final RecipesRepo _recipesRepo;

  RecipeTypesCubit(this._recipesRepo) : super(const BaseState<CategoryModel>()) {
    fetchTypes();
  }

  Future<void> fetchTypes() async {
    emit(state.copyWith(status: Status.loading, errorMessage: null));
    final result = await _recipesRepo.getRecipeTypes();
    result.fold(
      (failure) => emit(state.copyWith(
        status: Status.error,
        errorMessage: failure.message,
      )),
      (types) => emit(state.copyWith(
        status: Status.success,
        items: types,
      )),
    );
  }
}
