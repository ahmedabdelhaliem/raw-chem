// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      id: (json['id'] as num).toInt(),
      lastMessage: json['last_message'] as String?,
      lastMessageTime: json['last_message_time'] as String?,
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      supplier:
          SupplierModel.fromJson(json['supplier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'last_message': instance.lastMessage,
      'last_message_time': instance.lastMessageTime,
      'unread_count': instance.unreadCount,
      'supplier': instance.supplier,
    };
