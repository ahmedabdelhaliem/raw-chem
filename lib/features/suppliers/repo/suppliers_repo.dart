import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/suppliers/model/supplier_model.dart';
import 'package:raw_chem/common/model/paginated_response.dart';
import 'package:raw_chem/common/http/params.dart';

class SuppliersRepo {
  final GenericDataSource _dataSource;

  SuppliersRepo(this._dataSource);

  Future<Either<Failure, PaginatedResponse<SupplierModel>>> getSuppliers({int page = 1}) async {
    return await _dataSource.fetchPaginatedData<SupplierModel>(
      endpoint: EndPoints.suppliers,
      params: PaginationParams(page: page, limit: 10),
      fromJson: (json) => SupplierModel.fromJson(json),
    );
  }

  Future<Either<Failure, PaginatedResponse<PriceTrackerModel>>> getSupplierMaterials({required int supplierId, int page = 1}) async {
    return await _dataSource.fetchPaginatedData<PriceTrackerModel>(
      endpoint: EndPoints.supplierMaterials,
      queryParameters: {'supplier_id': supplierId},
      params: PaginationParams(page: page, limit: 10),
      fromJson: (json) => PriceTrackerModel.fromJson(json),
    );
  }
}
