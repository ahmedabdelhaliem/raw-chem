// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_forgot_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifyOtpForgotRequest _$VerifyOtpForgotRequestFromJson(
    Map<String, dynamic> json) {
  return _VerifyOtpForgotRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyOtpForgotRequest {
  String get phone => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyOtpForgotRequestCopyWith<VerifyOtpForgotRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOtpForgotRequestCopyWith<$Res> {
  factory $VerifyOtpForgotRequestCopyWith(VerifyOtpForgotRequest value,
          $Res Function(VerifyOtpForgotRequest) then) =
      _$VerifyOtpForgotRequestCopyWithImpl<$Res, VerifyOtpForgotRequest>;
  @useResult
  $Res call({String phone, String token});
}

/// @nodoc
class _$VerifyOtpForgotRequestCopyWithImpl<$Res,
        $Val extends VerifyOtpForgotRequest>
    implements $VerifyOtpForgotRequestCopyWith<$Res> {
  _$VerifyOtpForgotRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyOtpForgotRequestImplCopyWith<$Res>
    implements $VerifyOtpForgotRequestCopyWith<$Res> {
  factory _$$VerifyOtpForgotRequestImplCopyWith(
          _$VerifyOtpForgotRequestImpl value,
          $Res Function(_$VerifyOtpForgotRequestImpl) then) =
      __$$VerifyOtpForgotRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone, String token});
}

/// @nodoc
class __$$VerifyOtpForgotRequestImplCopyWithImpl<$Res>
    extends _$VerifyOtpForgotRequestCopyWithImpl<$Res,
        _$VerifyOtpForgotRequestImpl>
    implements _$$VerifyOtpForgotRequestImplCopyWith<$Res> {
  __$$VerifyOtpForgotRequestImplCopyWithImpl(
      _$VerifyOtpForgotRequestImpl _value,
      $Res Function(_$VerifyOtpForgotRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? token = null,
  }) {
    return _then(_$VerifyOtpForgotRequestImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyOtpForgotRequestImpl implements _VerifyOtpForgotRequest {
  const _$VerifyOtpForgotRequestImpl(
      {required this.phone, required this.token});

  factory _$VerifyOtpForgotRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyOtpForgotRequestImplFromJson(json);

  @override
  final String phone;
  @override
  final String token;

  @override
  String toString() {
    return 'VerifyOtpForgotRequest(phone: $phone, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpForgotRequestImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpForgotRequestImplCopyWith<_$VerifyOtpForgotRequestImpl>
      get copyWith => __$$VerifyOtpForgotRequestImplCopyWithImpl<
          _$VerifyOtpForgotRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyOtpForgotRequestImplToJson(
      this,
    );
  }
}

abstract class _VerifyOtpForgotRequest implements VerifyOtpForgotRequest {
  const factory _VerifyOtpForgotRequest(
      {required final String phone,
      required final String token}) = _$VerifyOtpForgotRequestImpl;

  factory _VerifyOtpForgotRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyOtpForgotRequestImpl.fromJson;

  @override
  String get phone;
  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$VerifyOtpForgotRequestImplCopyWith<_$VerifyOtpForgotRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
