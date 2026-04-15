import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/params.dart';

class PriceTrackerRepo {
  final GenericDataSource _dataSource;

  PriceTrackerRepo(this._dataSource);

  Future<Either<Failure, PaginatedResponse<PriceTrackerModel>>> getSupplierMaterials({
    int page = 1,
    String? q,
    String? casNumber,
    List<int>? materialFamilyIds,
    int? supplierId,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (q != null && q.isNotEmpty) queryParams['q'] = q;
    if (casNumber != null && casNumber.isNotEmpty) queryParams['cas_number'] = casNumber;
    if (materialFamilyIds != null && materialFamilyIds.isNotEmpty) {
      queryParams['material_family_ids'] = materialFamilyIds.join(',');
    }
    if (supplierId != null) queryParams['supplier_id'] = supplierId;

    return await _dataSource.fetchPaginatedData<PriceTrackerModel>(
      endpoint: EndPoints.supplierMaterials,
      params: PaginationParams(
        page: page,
        limit: 10,
      ),
      queryParameters: queryParams,
      fromJson: (json) => PriceTrackerModel.fromJson(json),
    );
  }

  Future<Either<Failure, RawMaterialModel>> getSupplierMaterialDetails(int id) async {
    return await _dataSource.fetchResult<RawMaterialModel>(
      endpoint: '${EndPoints.supplierMaterials}/$id',
      fromJson: (json) => RawMaterialModel.fromJson(json),
    );
  }
}
