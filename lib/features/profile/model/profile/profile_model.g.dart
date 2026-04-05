// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileResponseImpl _$$ProfileResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : ProfileUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProfileResponseImplToJson(
        _$ProfileResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$ProfileUserImpl _$$ProfileUserImplFromJson(Map<String, dynamic> json) =>
    _$ProfileUserImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      companyName: json['company_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      fcmToken: json['fcm_token'] as String?,
      status: (json['status'] as num?)?.toInt(),
      emailVerifiedAt: json['email_verified_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ProfileUserImplToJson(_$ProfileUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company_name': instance.companyName,
      'email': instance.email,
      'phone': instance.phone,
      'category': instance.category,
      'fcm_token': instance.fcmToken,
      'status': instance.status,
      'email_verified_at': instance.emailVerifiedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
