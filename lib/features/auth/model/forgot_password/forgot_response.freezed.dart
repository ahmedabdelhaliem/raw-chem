// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ForgotResponse _$ForgotResponseFromJson(Map<String, dynamic> json) {
  return _ForgotResponse.fromJson(json);
}

/// @nodoc
mixin _$ForgotResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForgotResponseCopyWith<ForgotResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotResponseCopyWith<$Res> {
  factory $ForgotResponseCopyWith(
          ForgotResponse value, $Res Function(ForgotResponse) then) =
      _$ForgotResponseCopyWithImpl<$Res, ForgotResponse>;
  @useResult
  $Res call({int code, String message, dynamic data});
}

/// @nodoc
class _$ForgotResponseCopyWithImpl<$Res, $Val extends ForgotResponse>
    implements $ForgotResponseCopyWith<$Res> {
  _$ForgotResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForgotResponseImplCopyWith<$Res>
    implements $ForgotResponseCopyWith<$Res> {
  factory _$$ForgotResponseImplCopyWith(_$ForgotResponseImpl value,
          $Res Function(_$ForgotResponseImpl) then) =
      __$$ForgotResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, dynamic data});
}

/// @nodoc
class __$$ForgotResponseImplCopyWithImpl<$Res>
    extends _$ForgotResponseCopyWithImpl<$Res, _$ForgotResponseImpl>
    implements _$$ForgotResponseImplCopyWith<$Res> {
  __$$ForgotResponseImplCopyWithImpl(
      _$ForgotResponseImpl _value, $Res Function(_$ForgotResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$ForgotResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgotResponseImpl implements _ForgotResponse {
  const _$ForgotResponseImpl(
      {required this.code, required this.message, this.data});

  factory _$ForgotResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgotResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'ForgotResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotResponseImplCopyWith<_$ForgotResponseImpl> get copyWith =>
      __$$ForgotResponseImplCopyWithImpl<_$ForgotResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotResponseImplToJson(
      this,
    );
  }
}

abstract class _ForgotResponse implements ForgotResponse {
  const factory _ForgotResponse(
      {required final int code,
      required final String message,
      final dynamic data}) = _$ForgotResponseImpl;

  factory _ForgotResponse.fromJson(Map<String, dynamic> json) =
      _$ForgotResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$ForgotResponseImplCopyWith<_$ForgotResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
