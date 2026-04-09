// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String,
      message: json['message'] as String,
      senderId: json['sender_id'] as String,
      chatId: json['chat_id'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'sender_id': instance.senderId,
      'chat_id': instance.chatId,
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
