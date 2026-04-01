// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForgotResponseImpl _$$ForgotResponseImplFromJson(Map<String, dynamic> json) =>
    _$ForgotResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$$ForgotResponseImplToJson(
        _$ForgotResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
