// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  dynamic get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_type')
  String? get senderType => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  dynamic get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_name')
  String? get senderName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  @JsonKey(name: 'attachment_url')
  String? get attachmentUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call(
      {dynamic id,
      @JsonKey(name: 'sender_type') String? senderType,
      @JsonKey(name: 'sender_id') dynamic senderId,
      @JsonKey(name: 'sender_name') String? senderName,
      String type,
      String? body,
      @JsonKey(name: 'attachment_url') String? attachmentUrl,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? senderType = freezed,
    Object? senderId = freezed,
    Object? senderName = freezed,
    Object? type = null,
    Object? body = freezed,
    Object? attachmentUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      senderType: freezed == senderType
          ? _value.senderType
          : senderType // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrl: freezed == attachmentUrl
          ? _value.attachmentUrl
          : attachmentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
          _$MessageModelImpl value, $Res Function(_$MessageModelImpl) then) =
      __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      @JsonKey(name: 'sender_type') String? senderType,
      @JsonKey(name: 'sender_id') dynamic senderId,
      @JsonKey(name: 'sender_name') String? senderName,
      String type,
      String? body,
      @JsonKey(name: 'attachment_url') String? attachmentUrl,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
      _$MessageModelImpl _value, $Res Function(_$MessageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? senderType = freezed,
    Object? senderId = freezed,
    Object? senderName = freezed,
    Object? type = null,
    Object? body = freezed,
    Object? attachmentUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$MessageModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      senderType: freezed == senderType
          ? _value.senderType
          : senderType // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrl: freezed == attachmentUrl
          ? _value.attachmentUrl
          : attachmentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageModelImpl implements _MessageModel {
  const _$MessageModelImpl(
      {required this.id,
      @JsonKey(name: 'sender_type') this.senderType,
      @JsonKey(name: 'sender_id') this.senderId,
      @JsonKey(name: 'sender_name') this.senderName,
      required this.type,
      this.body,
      @JsonKey(name: 'attachment_url') this.attachmentUrl,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$MessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageModelImplFromJson(json);

  @override
  final dynamic id;
  @override
  @JsonKey(name: 'sender_type')
  final String? senderType;
  @override
  @JsonKey(name: 'sender_id')
  final dynamic senderId;
  @override
  @JsonKey(name: 'sender_name')
  final String? senderName;
  @override
  final String type;
  @override
  final String? body;
  @override
  @JsonKey(name: 'attachment_url')
  final String? attachmentUrl;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'MessageModel(id: $id, senderType: $senderType, senderId: $senderId, senderName: $senderName, type: $type, body: $body, attachmentUrl: $attachmentUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.senderType, senderType) ||
                other.senderType == senderType) &&
            const DeepCollectionEquality().equals(other.senderId, senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.attachmentUrl, attachmentUrl) ||
                other.attachmentUrl == attachmentUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      senderType,
      const DeepCollectionEquality().hash(senderId),
      senderName,
      type,
      body,
      attachmentUrl,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageModelImplToJson(
      this,
    );
  }
}

abstract class _MessageModel implements MessageModel {
  const factory _MessageModel(
          {required final dynamic id,
          @JsonKey(name: 'sender_type') final String? senderType,
          @JsonKey(name: 'sender_id') final dynamic senderId,
          @JsonKey(name: 'sender_name') final String? senderName,
          required final String type,
          final String? body,
          @JsonKey(name: 'attachment_url') final String? attachmentUrl,
          @JsonKey(name: 'created_at') required final String createdAt}) =
      _$MessageModelImpl;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$MessageModelImpl.fromJson;

  @override
  dynamic get id;
  @override
  @JsonKey(name: 'sender_type')
  String? get senderType;
  @override
  @JsonKey(name: 'sender_id')
  dynamic get senderId;
  @override
  @JsonKey(name: 'sender_name')
  String? get senderName;
  @override
  String get type;
  @override
  String? get body;
  @override
  @JsonKey(name: 'attachment_url')
  String? get attachmentUrl;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateChatResponse _$CreateChatResponseFromJson(Map<String, dynamic> json) {
  return _CreateChatResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateChatResponse {
  @JsonKey(name: 'chat_id')
  int get chatId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateChatResponseCopyWith<CreateChatResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateChatResponseCopyWith<$Res> {
  factory $CreateChatResponseCopyWith(
          CreateChatResponse value, $Res Function(CreateChatResponse) then) =
      _$CreateChatResponseCopyWithImpl<$Res, CreateChatResponse>;
  @useResult
  $Res call({@JsonKey(name: 'chat_id') int chatId});
}

/// @nodoc
class _$CreateChatResponseCopyWithImpl<$Res, $Val extends CreateChatResponse>
    implements $CreateChatResponseCopyWith<$Res> {
  _$CreateChatResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
  }) {
    return _then(_value.copyWith(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateChatResponseImplCopyWith<$Res>
    implements $CreateChatResponseCopyWith<$Res> {
  factory _$$CreateChatResponseImplCopyWith(_$CreateChatResponseImpl value,
          $Res Function(_$CreateChatResponseImpl) then) =
      __$$CreateChatResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'chat_id') int chatId});
}

/// @nodoc
class __$$CreateChatResponseImplCopyWithImpl<$Res>
    extends _$CreateChatResponseCopyWithImpl<$Res, _$CreateChatResponseImpl>
    implements _$$CreateChatResponseImplCopyWith<$Res> {
  __$$CreateChatResponseImplCopyWithImpl(_$CreateChatResponseImpl _value,
      $Res Function(_$CreateChatResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
  }) {
    return _then(_$CreateChatResponseImpl(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateChatResponseImpl implements _CreateChatResponse {
  const _$CreateChatResponseImpl(
      {@JsonKey(name: 'chat_id') required this.chatId});

  factory _$CreateChatResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateChatResponseImplFromJson(json);

  @override
  @JsonKey(name: 'chat_id')
  final int chatId;

  @override
  String toString() {
    return 'CreateChatResponse(chatId: $chatId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateChatResponseImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chatId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateChatResponseImplCopyWith<_$CreateChatResponseImpl> get copyWith =>
      __$$CreateChatResponseImplCopyWithImpl<_$CreateChatResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateChatResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateChatResponse implements CreateChatResponse {
  const factory _CreateChatResponse(
          {@JsonKey(name: 'chat_id') required final int chatId}) =
      _$CreateChatResponseImpl;

  factory _CreateChatResponse.fromJson(Map<String, dynamic> json) =
      _$CreateChatResponseImpl.fromJson;

  @override
  @JsonKey(name: 'chat_id')
  int get chatId;
  @override
  @JsonKey(ignore: true)
  _$$CreateChatResponseImplCopyWith<_$CreateChatResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
