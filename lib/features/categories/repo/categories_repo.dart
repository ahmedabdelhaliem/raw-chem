import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/core/api/api_endpoints.dart';
import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/features/raw_materials/model/raw_material_model.dart';
import 'package:raw_chem/features/recipes/model/recipe_model.dart';
import 'package:raw_chem/common/model/paginated_response.dart';
class CategoriesRepo {
  final GenericDataSource _dataSource;

  CategoriesRepo(this._dataSource);

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return await _dataSource.fetchData<CategoryModel>(
      endpoint: EndPoints.categories,
      fromJson: (json) => CategoryModel.fromJson(json),
    );
  }
  Future<Either<Failure, PaginatedResponse<RecipeModel>>> getCategoryRecipes({
    required int categoryId,
    int page = 1,
  }) async {
    return await _dataSource.fetchPaginatedData<RecipeModel>(
      endpoint: EndPoints.categoryItems(categoryId),
      queryParameters: {'type': 'recipes', 'page': page, 'limit': 10},
      fromJson: (json) => RecipeModel.fromJson(json),
    );
  }

  Future<Either<Failure, PaginatedResponse<RawMaterialModel>>> getCategoryMaterials({
    required int categoryId,
    int page = 1,
  }) async {
    return await _dataSource.fetchPaginatedData<RawMaterialModel>(
      endpoint: EndPoints.categoryItems(categoryId),
      queryParameters: {'type': 'materials', 'page': page, 'limit': 10},
      fromJson: (json) => RawMaterialModel.fromJson(json),
    );
  }
}
