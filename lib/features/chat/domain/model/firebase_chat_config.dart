import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_chat_config.freezed.dart';
part 'firebase_chat_config.g.dart';

@freezed
class FirebaseChatConfig with _$FirebaseChatConfig {
  const factory FirebaseChatConfig({
    @JsonKey(name: 'firebase_custom_token') required String customToken,
    @JsonKey(name: 'firebase_database_url') required String databaseUrl,
    @JsonKey(name: 'purchase_order_id') required int purchaseOrderId,
    @JsonKey(name: 'firebase_messages_path') required String messagesPath,
  }) = _FirebaseChatConfig;

  factory FirebaseChatConfig.fromJson(Map<String, dynamic> json) =>
      _$FirebaseChatConfigFromJson(json);
}
