// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifyOtpResponseImpl _$$VerifyOtpResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyOtpResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : VerifyOtpData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VerifyOtpResponseImplToJson(
        _$VerifyOtpResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$VerifyOtpDataImpl _$$VerifyOtpDataImplFromJson(Map<String, dynamic> json) =>
    _$VerifyOtpDataImpl(
      user: json['user'] == null
          ? null
          : VerifyOtpUser.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$VerifyOtpDataImplToJson(_$VerifyOtpDataImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

_$VerifyOtpUserImpl _$$VerifyOtpUserImplFromJson(Map<String, dynamic> json) =>
    _$VerifyOtpUserImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      companyName: json['company_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$VerifyOtpUserImplToJson(_$VerifyOtpUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company_name': instance.companyName,
      'email': instance.email,
      'phone': instance.phone,
      'category': instance.category,
      'status': instance.status,
    };
