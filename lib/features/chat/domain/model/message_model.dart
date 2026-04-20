import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required dynamic id,
    @JsonKey(name: 'sender_type') String? senderType,
    @JsonKey(name: 'sender_id') dynamic senderId,
    @JsonKey(name: 'sender_name') String? senderName,
    required String type,
    String? body,
    @JsonKey(name: 'attachment_url') String? attachmentUrl,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

@freezed
class CreateChatResponse with _$CreateChatResponse {
  const factory CreateChatResponse({
    @JsonKey(name: 'chat_id') required int chatId,
  }) = _CreateChatResponse;

  factory CreateChatResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateChatResponseFromJson(json);
}
