// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationMetadataModelImpl _$$NotificationMetadataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationMetadataModelImpl(
      type: json['type'] as String?,
      status: json['status'] as String?,
      purchaseOrderId: (json['purchase_order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$NotificationMetadataModelImplToJson(
        _$NotificationMetadataModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'status': instance.status,
      'purchase_order_id': instance.purchaseOrderId,
    };

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
      metadata: json['metadata'] == null
          ? null
          : NotificationMetadataModel.fromJson(
              json['metadata'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'metadata': instance.metadata,
      'created_at': instance.createdAt,
    };
