import 'package:raw_chem/app/imports.dart';
import 'package:raw_chem/common/data_source/generic_data_source.dart';
import 'package:raw_chem/common/http/either.dart';
import 'package:raw_chem/common/http/failure.dart';
import 'package:raw_chem/features/price_tracker/model/price_tracker_model.dart';
import 'package:raw_chem/common/model/paginated_response.dart';
import 'package:raw_chem/common/http/params.dart';

class PriceTrackerRepo {
  final GenericDataSource _dataSource;

  PriceTrackerRepo(this._dataSource);

  Future<Either<Failure, PaginatedResponse<PriceTrackerModel>>> getSupplierMaterials({int page = 1}) async {
    return await _dataSource.fetchPaginatedData<PriceTrackerModel>(
      endpoint: EndPoints.supplierMaterials,
      params: PaginationParams(page: page, limit: 10),
      fromJson: (json) => PriceTrackerModel.fromJson(json),
    );
  }
}
