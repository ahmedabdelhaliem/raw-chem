// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterResponseImpl _$$RegisterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : RegisterData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RegisterResponseImplToJson(
        _$RegisterResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$RegisterDataImpl _$$RegisterDataImplFromJson(Map<String, dynamic> json) =>
    _$RegisterDataImpl(
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$RegisterDataImplToJson(_$RegisterDataImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
    };
