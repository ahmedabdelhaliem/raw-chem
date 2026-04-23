// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsResponseImpl _$$SettingsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingsResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => SettingsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SettingsResponseImplToJson(
        _$SettingsResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$SettingsModelImpl _$$SettingsModelImplFromJson(Map<String, dynamic> json) =>
    _$SettingsModelImpl(
      name: json['name'] as String?,
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      address: json['address'] as String?,
      metaKey: json['metaKey'] as String?,
      metaDesc: json['metaDesc'] as String?,
      phone: json['phone'] as String?,
      whatsapp: json['whatsapp'] as String?,
      email: json['email'] as String?,
      support: json['support'] as String?,
      facebook: json['facebook'] as String?,
      xUrl: json['xUrl'] as String?,
      youtube: json['youtube'] as String?,
      instagram: json['instagram'] as String?,
      tiktok: json['tiktok'] as String?,
      linkedin: json['linkedin'] as String?,
      logo: json['logo'] as String?,
      favicon: json['favicon'] as String?,
      copyright: json['copyright'] as String?,
      promotion: json['promotion'] as String?,
    );

Map<String, dynamic> _$$SettingsModelImplToJson(_$SettingsModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'desc': instance.desc,
      'address': instance.address,
      'metaKey': instance.metaKey,
      'metaDesc': instance.metaDesc,
      'phone': instance.phone,
      'whatsapp': instance.whatsapp,
      'email': instance.email,
      'support': instance.support,
      'facebook': instance.facebook,
      'xUrl': instance.xUrl,
      'youtube': instance.youtube,
      'instagram': instance.instagram,
      'tiktok': instance.tiktok,
      'linkedin': instance.linkedin,
      'logo': instance.logo,
      'favicon': instance.favicon,
      'copyright': instance.copyright,
      'promotion': instance.promotion,
    };
