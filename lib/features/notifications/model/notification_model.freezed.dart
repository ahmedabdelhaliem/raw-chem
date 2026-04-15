// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationMetadataModel _$NotificationMetadataModelFromJson(
    Map<String, dynamic> json) {
  return _NotificationMetadataModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationMetadataModel {
  String? get type => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_order_id')
  int? get purchaseOrderId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationMetadataModelCopyWith<NotificationMetadataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationMetadataModelCopyWith<$Res> {
  factory $NotificationMetadataModelCopyWith(NotificationMetadataModel value,
          $Res Function(NotificationMetadataModel) then) =
      _$NotificationMetadataModelCopyWithImpl<$Res, NotificationMetadataModel>;
  @useResult
  $Res call(
      {String? type,
      String? status,
      @JsonKey(name: 'purchase_order_id') int? purchaseOrderId});
}

/// @nodoc
class _$NotificationMetadataModelCopyWithImpl<$Res,
        $Val extends NotificationMetadataModel>
    implements $NotificationMetadataModelCopyWith<$Res> {
  _$NotificationMetadataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? status = freezed,
    Object? purchaseOrderId = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationMetadataModelImplCopyWith<$Res>
    implements $NotificationMetadataModelCopyWith<$Res> {
  factory _$$NotificationMetadataModelImplCopyWith(
          _$NotificationMetadataModelImpl value,
          $Res Function(_$NotificationMetadataModelImpl) then) =
      __$$NotificationMetadataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? type,
      String? status,
      @JsonKey(name: 'purchase_order_id') int? purchaseOrderId});
}

/// @nodoc
class __$$NotificationMetadataModelImplCopyWithImpl<$Res>
    extends _$NotificationMetadataModelCopyWithImpl<$Res,
        _$NotificationMetadataModelImpl>
    implements _$$NotificationMetadataModelImplCopyWith<$Res> {
  __$$NotificationMetadataModelImplCopyWithImpl(
      _$NotificationMetadataModelImpl _value,
      $Res Function(_$NotificationMetadataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? status = freezed,
    Object? purchaseOrderId = freezed,
  }) {
    return _then(_$NotificationMetadataModelImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationMetadataModelImpl implements _NotificationMetadataModel {
  const _$NotificationMetadataModelImpl(
      {this.type,
      this.status,
      @JsonKey(name: 'purchase_order_id') this.purchaseOrderId});

  factory _$NotificationMetadataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationMetadataModelImplFromJson(json);

  @override
  final String? type;
  @override
  final String? status;
  @override
  @JsonKey(name: 'purchase_order_id')
  final int? purchaseOrderId;

  @override
  String toString() {
    return 'NotificationMetadataModel(type: $type, status: $status, purchaseOrderId: $purchaseOrderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationMetadataModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.purchaseOrderId, purchaseOrderId) ||
                other.purchaseOrderId == purchaseOrderId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, status, purchaseOrderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationMetadataModelImplCopyWith<_$NotificationMetadataModelImpl>
      get copyWith => __$$NotificationMetadataModelImplCopyWithImpl<
          _$NotificationMetadataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationMetadataModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationMetadataModel implements NotificationMetadataModel {
  const factory _NotificationMetadataModel(
          {final String? type,
          final String? status,
          @JsonKey(name: 'purchase_order_id') final int? purchaseOrderId}) =
      _$NotificationMetadataModelImpl;

  factory _NotificationMetadataModel.fromJson(Map<String, dynamic> json) =
      _$NotificationMetadataModelImpl.fromJson;

  @override
  String? get type;
  @override
  String? get status;
  @override
  @JsonKey(name: 'purchase_order_id')
  int? get purchaseOrderId;
  @override
  @JsonKey(ignore: true)
  _$$NotificationMetadataModelImplCopyWith<_$NotificationMetadataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return _NotificationModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationModel {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  NotificationMetadataModel? get metadata => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
          NotificationModel value, $Res Function(NotificationModel) then) =
      _$NotificationModelCopyWithImpl<$Res, NotificationModel>;
  @useResult
  $Res call(
      {int id,
      String? title,
      String? body,
      NotificationMetadataModel? metadata,
      @JsonKey(name: 'created_at') String? createdAt});

  $NotificationMetadataModelCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res, $Val extends NotificationModel>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? body = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as NotificationMetadataModel?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationMetadataModelCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $NotificationMetadataModelCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationModelImplCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$$NotificationModelImplCopyWith(_$NotificationModelImpl value,
          $Res Function(_$NotificationModelImpl) then) =
      __$$NotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? title,
      String? body,
      NotificationMetadataModel? metadata,
      @JsonKey(name: 'created_at') String? createdAt});

  @override
  $NotificationMetadataModelCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$$NotificationModelImplCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res, _$NotificationModelImpl>
    implements _$$NotificationModelImplCopyWith<$Res> {
  __$$NotificationModelImplCopyWithImpl(_$NotificationModelImpl _value,
      $Res Function(_$NotificationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? body = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$NotificationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as NotificationMetadataModel?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationModelImpl implements _NotificationModel {
  const _$NotificationModelImpl(
      {required this.id,
      this.title,
      this.body,
      this.metadata,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$NotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationModelImplFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final String? body;
  @override
  final NotificationMetadataModel? metadata;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, body: $body, metadata: $metadata, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, body, metadata, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      __$$NotificationModelImplCopyWithImpl<_$NotificationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationModel implements NotificationModel {
  const factory _NotificationModel(
          {required final int id,
          final String? title,
          final String? body,
          final NotificationMetadataModel? metadata,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$NotificationModelImpl;

  factory _NotificationModel.fromJson(Map<String, dynamic> json) =
      _$NotificationModelImpl.fromJson;

  @override
  int get id;
  @override
  String? get title;
  @override
  String? get body;
  @override
  NotificationMetadataModel? get metadata;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
