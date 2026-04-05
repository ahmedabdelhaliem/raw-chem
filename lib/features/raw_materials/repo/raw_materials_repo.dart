import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/raw_materials/model/raw_material_model.dart';
import 'package:raw_chem/common/model/paginated_response.dart';
import 'package:raw_chem/common/http/params.dart';

class RawMaterialsRepo {
  final GenericDataSource _dataSource;

  RawMaterialsRepo(this._dataSource);

  Future<Either<Failure, PaginatedResponse<RawMaterialModel>>> getMaterials({int page = 1}) async {
    return await _dataSource.fetchPaginatedData<RawMaterialModel>(
      endpoint: EndPoints.materials,
      params: PaginationParams(page: page, limit: 10),
      fromJson: (json) => RawMaterialModel.fromJson(json),
    );
  }

  Future<Either<Failure, RawMaterialModel>> getMaterialDetails(int id) async {
    return await _dataSource.fetchResult<RawMaterialModel>(
      endpoint: '${EndPoints.materials}/$id',
      fromJson: (json) => RawMaterialModel.fromJson(json),
    );
  }
}
