// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeResponseImpl _$$RecipeResponseImplFromJson(Map<String, dynamic> json) =>
    _$RecipeResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RecipeResponseImplToJson(
        _$RecipeResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };

_$RecipeDetailsResponseImpl _$$RecipeDetailsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$RecipeDetailsResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: RecipeModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RecipeDetailsResponseImplToJson(
        _$RecipeDetailsResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$RecipeModelImpl _$$RecipeModelImplFromJson(Map<String, dynamic> json) =>
    _$RecipeModelImpl(
      id: (json['id'] as num).toInt(),
      order: json['order'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      ingredients: json['ingredients'] as String?,
      measurements: json['measurements'] as String?,
      preparationInstructions: json['preparation_instructions'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$RecipeModelImplToJson(_$RecipeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'measurements': instance.measurements,
      'preparation_instructions': instance.preparationInstructions,
      'image': instance.image,
    };
