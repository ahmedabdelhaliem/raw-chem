import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:raw_chem/features/raw_materials/model/raw_material_model.dart';
import 'package:raw_chem/features/suppliers/model/supplier_model.dart';

part 'price_tracker_model.freezed.dart';
part 'price_tracker_model.g.dart';

@freezed
class PriceTrackerModel with _$PriceTrackerModel {
  const PriceTrackerModel._();

  const factory PriceTrackerModel({
    required int id,
    SupplierModel? supplier,
    MaterialFamilyModel? family,
    String? name,
    @JsonKey(name: 'cas_number') String? casNumber,
    String? description,
    String? image,
    String? price,
    @JsonKey(name: 'min_price') String? minPrice,
    @JsonKey(name: 'max_price') String? maxPrice,
    @JsonKey(name: 'average_price') String? averagePrice,
    String? date,
  }) = _PriceTrackerModel;

  factory PriceTrackerModel.fromJson(Map<String, dynamic> json) =>
      _$PriceTrackerModelFromJson(json);

  RawMaterialModel toRawMaterial() {
    return RawMaterialModel(
      id: id,
      name: name,
      description: description,
      casNumber: casNumber,
      image: image,
      family: family,
    );
  }
}
