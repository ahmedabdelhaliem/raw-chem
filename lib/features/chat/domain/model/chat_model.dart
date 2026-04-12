import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:raw_chem/features/suppliers/model/supplier_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    required int id,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_message_time') String? lastMessageTime,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    required SupplierModel supplier,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
