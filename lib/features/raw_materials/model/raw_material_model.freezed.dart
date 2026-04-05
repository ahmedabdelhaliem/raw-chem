// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_material_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MaterialFamilyModel _$MaterialFamilyModelFromJson(Map<String, dynamic> json) {
  return _MaterialFamilyModel.fromJson(json);
}

/// @nodoc
mixin _$MaterialFamilyModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaterialFamilyModelCopyWith<MaterialFamilyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialFamilyModelCopyWith<$Res> {
  factory $MaterialFamilyModelCopyWith(
          MaterialFamilyModel value, $Res Function(MaterialFamilyModel) then) =
      _$MaterialFamilyModelCopyWithImpl<$Res, MaterialFamilyModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$MaterialFamilyModelCopyWithImpl<$Res, $Val extends MaterialFamilyModel>
    implements $MaterialFamilyModelCopyWith<$Res> {
  _$MaterialFamilyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MaterialFamilyModelImplCopyWith<$Res>
    implements $MaterialFamilyModelCopyWith<$Res> {
  factory _$$MaterialFamilyModelImplCopyWith(_$MaterialFamilyModelImpl value,
          $Res Function(_$MaterialFamilyModelImpl) then) =
      __$$MaterialFamilyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$MaterialFamilyModelImplCopyWithImpl<$Res>
    extends _$MaterialFamilyModelCopyWithImpl<$Res, _$MaterialFamilyModelImpl>
    implements _$$MaterialFamilyModelImplCopyWith<$Res> {
  __$$MaterialFamilyModelImplCopyWithImpl(_$MaterialFamilyModelImpl _value,
      $Res Function(_$MaterialFamilyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$MaterialFamilyModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MaterialFamilyModelImpl implements _MaterialFamilyModel {
  const _$MaterialFamilyModelImpl({required this.id, required this.name});

  factory _$MaterialFamilyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialFamilyModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'MaterialFamilyModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialFamilyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialFamilyModelImplCopyWith<_$MaterialFamilyModelImpl> get copyWith =>
      __$$MaterialFamilyModelImplCopyWithImpl<_$MaterialFamilyModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialFamilyModelImplToJson(
      this,
    );
  }
}

abstract class _MaterialFamilyModel implements MaterialFamilyModel {
  const factory _MaterialFamilyModel(
      {required final int id,
      required final String name}) = _$MaterialFamilyModelImpl;

  factory _MaterialFamilyModel.fromJson(Map<String, dynamic> json) =
      _$MaterialFamilyModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$MaterialFamilyModelImplCopyWith<_$MaterialFamilyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RawMaterialModel _$RawMaterialModelFromJson(Map<String, dynamic> json) {
  return _RawMaterialModel.fromJson(json);
}

/// @nodoc
mixin _$RawMaterialModel {
  int get id => throw _privateConstructorUsedError;
  MaterialFamilyModel? get family => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'cas_number')
  String? get casNumber => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RawMaterialModelCopyWith<RawMaterialModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RawMaterialModelCopyWith<$Res> {
  factory $RawMaterialModelCopyWith(
          RawMaterialModel value, $Res Function(RawMaterialModel) then) =
      _$RawMaterialModelCopyWithImpl<$Res, RawMaterialModel>;
  @useResult
  $Res call(
      {int id,
      MaterialFamilyModel? family,
      String? name,
      @JsonKey(name: 'cas_number') String? casNumber,
      String? description,
      String? image});

  $MaterialFamilyModelCopyWith<$Res>? get family;
}

/// @nodoc
class _$RawMaterialModelCopyWithImpl<$Res, $Val extends RawMaterialModel>
    implements $RawMaterialModelCopyWith<$Res> {
  _$RawMaterialModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? family = freezed,
    Object? name = freezed,
    Object? casNumber = freezed,
    Object? description = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      family: freezed == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as MaterialFamilyModel?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      casNumber: freezed == casNumber
          ? _value.casNumber
          : casNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MaterialFamilyModelCopyWith<$Res>? get family {
    if (_value.family == null) {
      return null;
    }

    return $MaterialFamilyModelCopyWith<$Res>(_value.family!, (value) {
      return _then(_value.copyWith(family: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RawMaterialModelImplCopyWith<$Res>
    implements $RawMaterialModelCopyWith<$Res> {
  factory _$$RawMaterialModelImplCopyWith(_$RawMaterialModelImpl value,
          $Res Function(_$RawMaterialModelImpl) then) =
      __$$RawMaterialModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      MaterialFamilyModel? family,
      String? name,
      @JsonKey(name: 'cas_number') String? casNumber,
      String? description,
      String? image});

  @override
  $MaterialFamilyModelCopyWith<$Res>? get family;
}

/// @nodoc
class __$$RawMaterialModelImplCopyWithImpl<$Res>
    extends _$RawMaterialModelCopyWithImpl<$Res, _$RawMaterialModelImpl>
    implements _$$RawMaterialModelImplCopyWith<$Res> {
  __$$RawMaterialModelImplCopyWithImpl(_$RawMaterialModelImpl _value,
      $Res Function(_$RawMaterialModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? family = freezed,
    Object? name = freezed,
    Object? casNumber = freezed,
    Object? description = freezed,
    Object? image = freezed,
  }) {
    return _then(_$RawMaterialModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      family: freezed == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as MaterialFamilyModel?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      casNumber: freezed == casNumber
          ? _value.casNumber
          : casNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RawMaterialModelImpl implements _RawMaterialModel {
  const _$RawMaterialModelImpl(
      {required this.id,
      this.family,
      this.name,
      @JsonKey(name: 'cas_number') this.casNumber,
      this.description,
      this.image});

  factory _$RawMaterialModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RawMaterialModelImplFromJson(json);

  @override
  final int id;
  @override
  final MaterialFamilyModel? family;
  @override
  final String? name;
  @override
  @JsonKey(name: 'cas_number')
  final String? casNumber;
  @override
  final String? description;
  @override
  final String? image;

  @override
  String toString() {
    return 'RawMaterialModel(id: $id, family: $family, name: $name, casNumber: $casNumber, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RawMaterialModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.casNumber, casNumber) ||
                other.casNumber == casNumber) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, family, name, casNumber, description, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RawMaterialModelImplCopyWith<_$RawMaterialModelImpl> get copyWith =>
      __$$RawMaterialModelImplCopyWithImpl<_$RawMaterialModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RawMaterialModelImplToJson(
      this,
    );
  }
}

abstract class _RawMaterialModel implements RawMaterialModel {
  const factory _RawMaterialModel(
      {required final int id,
      final MaterialFamilyModel? family,
      final String? name,
      @JsonKey(name: 'cas_number') final String? casNumber,
      final String? description,
      final String? image}) = _$RawMaterialModelImpl;

  factory _RawMaterialModel.fromJson(Map<String, dynamic> json) =
      _$RawMaterialModelImpl.fromJson;

  @override
  int get id;
  @override
  MaterialFamilyModel? get family;
  @override
  String? get name;
  @override
  @JsonKey(name: 'cas_number')
  String? get casNumber;
  @override
  String? get description;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$RawMaterialModelImplCopyWith<_$RawMaterialModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
