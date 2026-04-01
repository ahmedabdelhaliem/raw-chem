// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaticPageResponseImpl _$$StaticPageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$StaticPageResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : StaticPageData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StaticPageResponseImplToJson(
        _$StaticPageResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$StaticPageDataImpl _$$StaticPageDataImplFromJson(Map<String, dynamic> json) =>
    _$StaticPageDataImpl(
      banner: json['banner'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$StaticPageDataImplToJson(
        _$StaticPageDataImpl instance) =>
    <String, dynamic>{
      'banner': instance.banner,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'updated_at': instance.updatedAt,
    };
