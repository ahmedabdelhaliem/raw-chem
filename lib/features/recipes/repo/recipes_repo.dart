import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/recipes/model/recipe_model.dart';
import 'package:raw_chem/common/model/paginated_response.dart';
import 'package:raw_chem/common/http/params.dart';

class RecipesRepo {
  final GenericDataSource _dataSource;

  RecipesRepo(this._dataSource);

  Future<Either<Failure, PaginatedResponse<RecipeModel>>> getRecipes({int page = 1}) async {
    return await _dataSource.fetchPaginatedData<RecipeModel>(
      endpoint: EndPoints.recipes,
      params: PaginationParams(page: page, limit: 10),
      fromJson: (json) => RecipeModel.fromJson(json),
    );
  }

  Future<Either<Failure, RecipeModel>> getRecipeDetails(int id) async {
    return await _dataSource.fetchResult<RecipeModel>(
      endpoint: '${EndPoints.recipes}/$id',
      fromJson: (json) => RecipeModel.fromJson(json),
    );
  }
}
