// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountryModelImpl _$$CountryModelImplFromJson(Map<String, dynamic> json) =>
    _$CountryModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      iso2: json['iso2'] as String?,
    );

Map<String, dynamic> _$$CountryModelImplToJson(_$CountryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iso2': instance.iso2,
    };

_$GovernorateModelImpl _$$GovernorateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GovernorateModelImpl(
      id: (json['id'] as num).toInt(),
      countryId: json['country_id'],
      name: json['name'] as String,
    );

Map<String, dynamic> _$$GovernorateModelImplToJson(
        _$GovernorateModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country_id': instance.countryId,
      'name': instance.name,
    };

_$CityModelImpl _$$CityModelImplFromJson(Map<String, dynamic> json) =>
    _$CityModelImpl(
      id: (json['id'] as num).toInt(),
      governorateId: json['governorate_id'],
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CityModelImplToJson(_$CityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'governorate_id': instance.governorateId,
      'name': instance.name,
    };
