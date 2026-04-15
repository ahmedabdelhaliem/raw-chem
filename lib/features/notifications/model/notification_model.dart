import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationMetadataModel with _$NotificationMetadataModel {
  const factory NotificationMetadataModel({
    String? type,
    String? status,
    @JsonKey(name: 'purchase_order_id') int? purchaseOrderId,
  }) = _NotificationMetadataModel;

  factory NotificationMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationMetadataModelFromJson(json);
}

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required int id,
    String? title,
    String? body,
    NotificationMetadataModel? metadata,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
