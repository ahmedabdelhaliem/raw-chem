// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_chat_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FirebaseChatConfig _$FirebaseChatConfigFromJson(Map<String, dynamic> json) {
  return _FirebaseChatConfig.fromJson(json);
}

/// @nodoc
mixin _$FirebaseChatConfig {
  @JsonKey(name: 'firebase_custom_token')
  String get customToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'firebase_database_url')
  String get databaseUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_order_id')
  int get purchaseOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'firebase_messages_path')
  String get messagesPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseChatConfigCopyWith<FirebaseChatConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseChatConfigCopyWith<$Res> {
  factory $FirebaseChatConfigCopyWith(
          FirebaseChatConfig value, $Res Function(FirebaseChatConfig) then) =
      _$FirebaseChatConfigCopyWithImpl<$Res, FirebaseChatConfig>;
  @useResult
  $Res call(
      {@JsonKey(name: 'firebase_custom_token') String customToken,
      @JsonKey(name: 'firebase_database_url') String databaseUrl,
      @JsonKey(name: 'purchase_order_id') int purchaseOrderId,
      @JsonKey(name: 'firebase_messages_path') String messagesPath});
}

/// @nodoc
class _$FirebaseChatConfigCopyWithImpl<$Res, $Val extends FirebaseChatConfig>
    implements $FirebaseChatConfigCopyWith<$Res> {
  _$FirebaseChatConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customToken = null,
    Object? databaseUrl = null,
    Object? purchaseOrderId = null,
    Object? messagesPath = null,
  }) {
    return _then(_value.copyWith(
      customToken: null == customToken
          ? _value.customToken
          : customToken // ignore: cast_nullable_to_non_nullable
              as String,
      databaseUrl: null == databaseUrl
          ? _value.databaseUrl
          : databaseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseOrderId: null == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      messagesPath: null == messagesPath
          ? _value.messagesPath
          : messagesPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirebaseChatConfigImplCopyWith<$Res>
    implements $FirebaseChatConfigCopyWith<$Res> {
  factory _$$FirebaseChatConfigImplCopyWith(_$FirebaseChatConfigImpl value,
          $Res Function(_$FirebaseChatConfigImpl) then) =
      __$$FirebaseChatConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'firebase_custom_token') String customToken,
      @JsonKey(name: 'firebase_database_url') String databaseUrl,
      @JsonKey(name: 'purchase_order_id') int purchaseOrderId,
      @JsonKey(name: 'firebase_messages_path') String messagesPath});
}

/// @nodoc
class __$$FirebaseChatConfigImplCopyWithImpl<$Res>
    extends _$FirebaseChatConfigCopyWithImpl<$Res, _$FirebaseChatConfigImpl>
    implements _$$FirebaseChatConfigImplCopyWith<$Res> {
  __$$FirebaseChatConfigImplCopyWithImpl(_$FirebaseChatConfigImpl _value,
      $Res Function(_$FirebaseChatConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customToken = null,
    Object? databaseUrl = null,
    Object? purchaseOrderId = null,
    Object? messagesPath = null,
  }) {
    return _then(_$FirebaseChatConfigImpl(
      customToken: null == customToken
          ? _value.customToken
          : customToken // ignore: cast_nullable_to_non_nullable
              as String,
      databaseUrl: null == databaseUrl
          ? _value.databaseUrl
          : databaseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseOrderId: null == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      messagesPath: null == messagesPath
          ? _value.messagesPath
          : messagesPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FirebaseChatConfigImpl implements _FirebaseChatConfig {
  const _$FirebaseChatConfigImpl(
      {@JsonKey(name: 'firebase_custom_token') required this.customToken,
      @JsonKey(name: 'firebase_database_url') required this.databaseUrl,
      @JsonKey(name: 'purchase_order_id') required this.purchaseOrderId,
      @JsonKey(name: 'firebase_messages_path') required this.messagesPath});

  factory _$FirebaseChatConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirebaseChatConfigImplFromJson(json);

  @override
  @JsonKey(name: 'firebase_custom_token')
  final String customToken;
  @override
  @JsonKey(name: 'firebase_database_url')
  final String databaseUrl;
  @override
  @JsonKey(name: 'purchase_order_id')
  final int purchaseOrderId;
  @override
  @JsonKey(name: 'firebase_messages_path')
  final String messagesPath;

  @override
  String toString() {
    return 'FirebaseChatConfig(customToken: $customToken, databaseUrl: $databaseUrl, purchaseOrderId: $purchaseOrderId, messagesPath: $messagesPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseChatConfigImpl &&
            (identical(other.customToken, customToken) ||
                other.customToken == customToken) &&
            (identical(other.databaseUrl, databaseUrl) ||
                other.databaseUrl == databaseUrl) &&
            (identical(other.purchaseOrderId, purchaseOrderId) ||
                other.purchaseOrderId == purchaseOrderId) &&
            (identical(other.messagesPath, messagesPath) ||
                other.messagesPath == messagesPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, customToken, databaseUrl, purchaseOrderId, messagesPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirebaseChatConfigImplCopyWith<_$FirebaseChatConfigImpl> get copyWith =>
      __$$FirebaseChatConfigImplCopyWithImpl<_$FirebaseChatConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirebaseChatConfigImplToJson(
      this,
    );
  }
}

abstract class _FirebaseChatConfig implements FirebaseChatConfig {
  const factory _FirebaseChatConfig(
      {@JsonKey(name: 'firebase_custom_token')
      required final String customToken,
      @JsonKey(name: 'firebase_database_url') required final String databaseUrl,
      @JsonKey(name: 'purchase_order_id') required final int purchaseOrderId,
      @JsonKey(name: 'firebase_messages_path')
      required final String messagesPath}) = _$FirebaseChatConfigImpl;

  factory _FirebaseChatConfig.fromJson(Map<String, dynamic> json) =
      _$FirebaseChatConfigImpl.fromJson;

  @override
  @JsonKey(name: 'firebase_custom_token')
  String get customToken;
  @override
  @JsonKey(name: 'firebase_database_url')
  String get databaseUrl;
  @override
  @JsonKey(name: 'purchase_order_id')
  int get purchaseOrderId;
  @override
  @JsonKey(name: 'firebase_messages_path')
  String get messagesPath;
  @override
  @JsonKey(ignore: true)
  _$$FirebaseChatConfigImplCopyWith<_$FirebaseChatConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
