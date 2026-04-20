// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_chat_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseChatConfigImpl _$$FirebaseChatConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseChatConfigImpl(
      customToken: json['firebase_custom_token'] as String,
      databaseUrl: json['firebase_database_url'] as String,
      purchaseOrderId: (json['purchase_order_id'] as num).toInt(),
      messagesPath: json['firebase_messages_path'] as String,
    );

Map<String, dynamic> _$$FirebaseChatConfigImplToJson(
        _$FirebaseChatConfigImpl instance) =>
    <String, dynamic>{
      'firebase_custom_token': instance.customToken,
      'firebase_database_url': instance.databaseUrl,
      'purchase_order_id': instance.purchaseOrderId,
      'firebase_messages_path': instance.messagesPath,
    };
