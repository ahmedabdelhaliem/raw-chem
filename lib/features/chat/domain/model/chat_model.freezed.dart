// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  String? get lastMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message_time')
  String? get lastMessageTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  SupplierModel get supplier => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'last_message') String? lastMessage,
      @JsonKey(name: 'last_message_time') String? lastMessageTime,
      @JsonKey(name: 'unread_count') int unreadCount,
      SupplierModel supplier});

  $SupplierModelCopyWith<$Res> get supplier;
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastMessage = freezed,
    Object? lastMessageTime = freezed,
    Object? unreadCount = null,
    Object? supplier = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageTime: freezed == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      supplier: null == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as SupplierModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SupplierModelCopyWith<$Res> get supplier {
    return $SupplierModelCopyWith<$Res>(_value.supplier, (value) {
      return _then(_value.copyWith(supplier: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatModelImplCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$$ChatModelImplCopyWith(
          _$ChatModelImpl value, $Res Function(_$ChatModelImpl) then) =
      __$$ChatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'last_message') String? lastMessage,
      @JsonKey(name: 'last_message_time') String? lastMessageTime,
      @JsonKey(name: 'unread_count') int unreadCount,
      SupplierModel supplier});

  @override
  $SupplierModelCopyWith<$Res> get supplier;
}

/// @nodoc
class __$$ChatModelImplCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$ChatModelImpl>
    implements _$$ChatModelImplCopyWith<$Res> {
  __$$ChatModelImplCopyWithImpl(
      _$ChatModelImpl _value, $Res Function(_$ChatModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastMessage = freezed,
    Object? lastMessageTime = freezed,
    Object? unreadCount = null,
    Object? supplier = null,
  }) {
    return _then(_$ChatModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageTime: freezed == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      supplier: null == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as SupplierModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatModelImpl implements _ChatModel {
  const _$ChatModelImpl(
      {required this.id,
      @JsonKey(name: 'last_message') this.lastMessage,
      @JsonKey(name: 'last_message_time') this.lastMessageTime,
      @JsonKey(name: 'unread_count') this.unreadCount = 0,
      required this.supplier});

  factory _$ChatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'last_message')
  final String? lastMessage;
  @override
  @JsonKey(name: 'last_message_time')
  final String? lastMessageTime;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  final SupplierModel supplier;

  @override
  String toString() {
    return 'ChatModel(id: $id, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount, supplier: $supplier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, lastMessage, lastMessageTime, unreadCount, supplier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      __$$ChatModelImplCopyWithImpl<_$ChatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatModelImplToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel(
      {required final int id,
      @JsonKey(name: 'last_message') final String? lastMessage,
      @JsonKey(name: 'last_message_time') final String? lastMessageTime,
      @JsonKey(name: 'unread_count') final int unreadCount,
      required final SupplierModel supplier}) = _$ChatModelImpl;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$ChatModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'last_message')
  String? get lastMessage;
  @override
  @JsonKey(name: 'last_message_time')
  String? get lastMessageTime;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  SupplierModel get supplier;
  @override
  @JsonKey(ignore: true)
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
