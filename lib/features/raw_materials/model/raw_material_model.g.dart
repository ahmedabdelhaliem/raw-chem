// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MaterialFamilyModelImpl _$$MaterialFamilyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MaterialFamilyModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$MaterialFamilyModelImplToJson(
        _$MaterialFamilyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$RawMaterialModelImpl _$$RawMaterialModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RawMaterialModelImpl(
      id: (json['id'] as num).toInt(),
      family: json['family'] == null
          ? null
          : MaterialFamilyModel.fromJson(
              json['family'] as Map<String, dynamic>),
      name: json['name'] as String?,
      casNumber: json['cas_number'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$RawMaterialModelImplToJson(
        _$RawMaterialModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'family': instance.family,
      'name': instance.name,
      'cas_number': instance.casNumber,
      'description': instance.description,
      'image': instance.image,
    };
