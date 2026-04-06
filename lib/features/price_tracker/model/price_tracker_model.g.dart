// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_tracker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceTrackerModelImpl _$$PriceTrackerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PriceTrackerModelImpl(
      id: (json['id'] as num).toInt(),
      supplier: json['supplier'] == null
          ? null
          : SupplierModel.fromJson(json['supplier'] as Map<String, dynamic>),
      family: json['family'] == null
          ? null
          : MaterialFamilyModel.fromJson(
              json['family'] as Map<String, dynamic>),
      name: json['name'] as String?,
      casNumber: json['cas_number'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      minPrice: json['min_price'] as String?,
      maxPrice: json['max_price'] as String?,
      averagePrice: json['average_price'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$$PriceTrackerModelImplToJson(
        _$PriceTrackerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplier': instance.supplier,
      'family': instance.family,
      'name': instance.name,
      'cas_number': instance.casNumber,
      'description': instance.description,
      'image': instance.image,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'average_price': instance.averagePrice,
      'date': instance.date,
    };
