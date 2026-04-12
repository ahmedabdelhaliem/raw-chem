import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_models.freezed.dart';
part 'location_models.g.dart';

@freezed
class CountryModel with _$CountryModel {
  const factory CountryModel({
    required int id,
    required String name,
    String? iso2,
  }) = _CountryModel;

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
}

@freezed
class GovernorateModel with _$GovernorateModel {
  const factory GovernorateModel({
    required int id,
    @JsonKey(name: 'country_id') dynamic countryId,
    required String name,
  }) = _GovernorateModel;

  factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
      _$GovernorateModelFromJson(json);
}

@freezed
class CityModel with _$CityModel {
  const factory CityModel({
    required int id,
    @JsonKey(name: 'governorate_id') dynamic governorateId,
    required String name,
  }) = _CityModel;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
}
