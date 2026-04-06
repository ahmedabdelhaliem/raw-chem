// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SupplierModel _$SupplierModelFromJson(Map<String, dynamic> json) {
  return _SupplierModel.fromJson(json);
}

/// @nodoc
mixin _$SupplierModel {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupplierModelCopyWith<SupplierModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierModelCopyWith<$Res> {
  factory $SupplierModelCopyWith(
          SupplierModel value, $Res Function(SupplierModel) then) =
      _$SupplierModelCopyWithImpl<$Res, SupplierModel>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? image,
      String? phone,
      String? email,
      String? address,
      String? desc});
}

/// @nodoc
class _$SupplierModelCopyWithImpl<$Res, $Val extends SupplierModel>
    implements $SupplierModelCopyWith<$Res> {
  _$SupplierModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? image = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? desc = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupplierModelImplCopyWith<$Res>
    implements $SupplierModelCopyWith<$Res> {
  factory _$$SupplierModelImplCopyWith(
          _$SupplierModelImpl value, $Res Function(_$SupplierModelImpl) then) =
      __$$SupplierModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? image,
      String? phone,
      String? email,
      String? address,
      String? desc});
}

/// @nodoc
class __$$SupplierModelImplCopyWithImpl<$Res>
    extends _$SupplierModelCopyWithImpl<$Res, _$SupplierModelImpl>
    implements _$$SupplierModelImplCopyWith<$Res> {
  __$$SupplierModelImplCopyWithImpl(
      _$SupplierModelImpl _value, $Res Function(_$SupplierModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? image = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? desc = freezed,
  }) {
    return _then(_$SupplierModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierModelImpl implements _SupplierModel {
  const _$SupplierModelImpl(
      {required this.id,
      this.name,
      this.image,
      this.phone,
      this.email,
      this.address,
      this.desc});

  factory _$SupplierModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierModelImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? image;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? address;
  @override
  final String? desc;

  @override
  String toString() {
    return 'SupplierModel(id: $id, name: $name, image: $image, phone: $phone, email: $email, address: $address, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, image, phone, email, address, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierModelImplCopyWith<_$SupplierModelImpl> get copyWith =>
      __$$SupplierModelImplCopyWithImpl<_$SupplierModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierModelImplToJson(
      this,
    );
  }
}

abstract class _SupplierModel implements SupplierModel {
  const factory _SupplierModel(
      {required final int id,
      final String? name,
      final String? image,
      final String? phone,
      final String? email,
      final String? address,
      final String? desc}) = _$SupplierModelImpl;

  factory _SupplierModel.fromJson(Map<String, dynamic> json) =
      _$SupplierModelImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get image;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get address;
  @override
  String? get desc;
  @override
  @JsonKey(ignore: true)
  _$$SupplierModelImplCopyWith<_$SupplierModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
