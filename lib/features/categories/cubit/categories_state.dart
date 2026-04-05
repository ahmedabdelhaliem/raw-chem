import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/app/imports.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesError extends CategoriesState {
  final Failure failure;
  CategoriesError(this.failure);
}
