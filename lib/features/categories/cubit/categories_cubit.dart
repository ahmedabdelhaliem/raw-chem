import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raw_chem/features/categories/cubit/categories_state.dart';
import 'package:raw_chem/features/categories/repo/categories_repo.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo _categoriesRepo;

  CategoriesCubit(this._categoriesRepo) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    if (isClosed) return;
    emit(CategoriesLoading());
    final result = await _categoriesRepo.getCategories();
    if (isClosed) return;
    result.fold(
      (failure) => emit(CategoriesError(failure)),
      (categories) => emit(CategoriesSuccess(categories)),
    );
  }
}
