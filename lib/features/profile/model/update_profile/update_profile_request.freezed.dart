// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_profile_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfileRequest {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_name')
  String get companyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateProfileRequestCopyWith<UpdateProfileRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileRequestCopyWith<$Res> {
  factory $UpdateProfileRequestCopyWith(UpdateProfileRequest value,
          $Res Function(UpdateProfileRequest) then) =
      _$UpdateProfileRequestCopyWithImpl<$Res, UpdateProfileRequest>;
  @useResult
  $Res call(
      {String name,
      String email,
      String phone,
      @JsonKey(name: 'company_name') String companyName,
      @JsonKey(name: 'category_id') int categoryId});
}

/// @nodoc
class _$UpdateProfileRequestCopyWithImpl<$Res,
        $Val extends UpdateProfileRequest>
    implements $UpdateProfileRequestCopyWith<$Res> {
  _$UpdateProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? companyName = null,
    Object? categoryId = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateProfileRequestImplCopyWith<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  factory _$$UpdateProfileRequestImplCopyWith(_$UpdateProfileRequestImpl value,
          $Res Function(_$UpdateProfileRequestImpl) then) =
      __$$UpdateProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String email,
      String phone,
      @JsonKey(name: 'company_name') String companyName,
      @JsonKey(name: 'category_id') int categoryId});
}

/// @nodoc
class __$$UpdateProfileRequestImplCopyWithImpl<$Res>
    extends _$UpdateProfileRequestCopyWithImpl<$Res, _$UpdateProfileRequestImpl>
    implements _$$UpdateProfileRequestImplCopyWith<$Res> {
  __$$UpdateProfileRequestImplCopyWithImpl(_$UpdateProfileRequestImpl _value,
      $Res Function(_$UpdateProfileRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? companyName = null,
    Object? categoryId = null,
  }) {
    return _then(_$UpdateProfileRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfileRequestImpl extends _UpdateProfileRequest {
  const _$UpdateProfileRequestImpl(
      {required this.name,
      required this.email,
      required this.phone,
      @JsonKey(name: 'company_name') required this.companyName,
      @JsonKey(name: 'category_id') required this.categoryId})
      : super._();

  factory _$UpdateProfileRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfileRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String phone;
  @override
  @JsonKey(name: 'company_name')
  final String companyName;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;

  @override
  String toString() {
    return 'UpdateProfileRequest(name: $name, email: $email, phone: $phone, companyName: $companyName, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, email, phone, companyName, categoryId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
      get copyWith =>
          __$$UpdateProfileRequestImplCopyWithImpl<_$UpdateProfileRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfileRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateProfileRequest extends UpdateProfileRequest {
  const factory _UpdateProfileRequest(
          {required final String name,
          required final String email,
          required final String phone,
          @JsonKey(name: 'company_name') required final String companyName,
          @JsonKey(name: 'category_id') required final int categoryId}) =
      _$UpdateProfileRequestImpl;
  const _UpdateProfileRequest._() : super._();

  factory _UpdateProfileRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfileRequestImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get phone;
  @override
  @JsonKey(name: 'company_name')
  String get companyName;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(ignore: true)
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
