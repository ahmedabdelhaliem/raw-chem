import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/core/api/api_endpoints.dart';
import 'package:raw_chem/app/imports.dart';

class CategoriesRepo {
  final GenericDataSource _dataSource;

  CategoriesRepo(this._dataSource);

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return await _dataSource.fetchData<CategoryModel>(
      endpoint: EndPoints.categories,
      fromJson: (json) => CategoryModel.fromJson(json),
    );
  }
}
