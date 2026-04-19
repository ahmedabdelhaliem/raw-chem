import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_material_model.freezed.dart';
part 'raw_material_model.g.dart';

@freezed
class MaterialFamilyModel with _$MaterialFamilyModel {
  const factory MaterialFamilyModel({
    required int id,
    required String name,
  }) = _MaterialFamilyModel;

  factory MaterialFamilyModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialFamilyModelFromJson(json);
}

@freezed
class RawMaterialModel with _$RawMaterialModel {
  const factory RawMaterialModel({
    required int id,
    MaterialFamilyModel? family,
    String? name,
    @JsonKey(name: 'cas_number') String? casNumber,
    String? description,
    String? image,
    String? price,
    String? date,
  }) = _RawMaterialModel;

  factory RawMaterialModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialModelFromJson(json);
}
