// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'],
      senderType: json['sender_type'] as String?,
      senderId: json['sender_id'],
      senderName: json['sender_name'] as String?,
      type: json['type'] as String,
      body: json['body'] as String?,
      attachmentUrl: json['attachment_url'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_type': instance.senderType,
      'sender_id': instance.senderId,
      'sender_name': instance.senderName,
      'type': instance.type,
      'body': instance.body,
      'attachment_url': instance.attachmentUrl,
      'created_at': instance.createdAt,
    };

_$CreateChatResponseImpl _$$CreateChatResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateChatResponseImpl(
      chatId: (json['chat_id'] as num).toInt(),
    );

Map<String, dynamic> _$$CreateChatResponseImplToJson(
        _$CreateChatResponseImpl instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
    };
