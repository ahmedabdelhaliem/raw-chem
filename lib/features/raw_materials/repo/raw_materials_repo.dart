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

  Future<Either<Failure, PaginatedResponse<RawMaterialModel>>> getMaterials({
    int page = 1,
    List<int>? materialFamilyIds,
    String? q,
    String? casNumber,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (materialFamilyIds != null && materialFamilyIds.isNotEmpty) {
      queryParams['material_family_ids'] = materialFamilyIds.join(',');
    }
    if (q != null && q.isNotEmpty) {
      queryParams['q'] = q;
    }
    if (casNumber != null && casNumber.isNotEmpty) {
      queryParams['cas_number'] = casNumber;
    }

    return await _dataSource.fetchPaginatedData<RawMaterialModel>(
      endpoint: EndPoints.materials,
      params: PaginationParams(page: page, limit: 10),
      queryParameters: queryParams,
      fromJson: (json) => RawMaterialModel.fromJson(json),
    );
  }

  Future<Either<Failure, RawMaterialModel>> getMaterialDetails(int id) async {
    return await _dataSource.fetchResult<RawMaterialModel>(
      endpoint: '${EndPoints.materials}/$id',
      fromJson: (json) => RawMaterialModel.fromJson(json),
    );
  }

  Future<Either<Failure, List<MaterialFamilyModel>>> getMaterialFamilies() async {
    return await _dataSource.fetchData<MaterialFamilyModel>(
      endpoint: EndPoints.materialFamilies,
      fromJson: (json) => MaterialFamilyModel.fromJson(json),
    );
  }

  Future<Either<Failure, dynamic>> createPurchaseOrder({
    required int materialId,
    required double quantity,
    required int countryId,
    required int governorateId,
    required int cityId,
    required String distinguishingMark,
    required String recipientPhone,
  }) async {
    return await _dataSource.fetchResult<dynamic>(
      endpoint: EndPoints.createPurchaseOrder,
      method: 'POST',
      data: {
        'supplier_material_id': materialId,
        'quantity': quantity,
        'country_id': countryId,
        'governorate_id': governorateId,
        'city_id': cityId,
        'distinguishing_mark': distinguishingMark,
        'recipient_phone': recipientPhone,
      },
      fromJson: (json) => json, // Returning the raw response data
    );
  }
}

