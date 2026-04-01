// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifyOtpResponse _$VerifyOtpResponseFromJson(Map<String, dynamic> json) {
  return _VerifyOtpResponse.fromJson(json);
}

/// @nodoc
mixin _$VerifyOtpResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  VerifyOtpData? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyOtpResponseCopyWith<VerifyOtpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOtpResponseCopyWith<$Res> {
  factory $VerifyOtpResponseCopyWith(
          VerifyOtpResponse value, $Res Function(VerifyOtpResponse) then) =
      _$VerifyOtpResponseCopyWithImpl<$Res, VerifyOtpResponse>;
  @useResult
  $Res call({int code, String message, VerifyOtpData? data});

  $VerifyOtpDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$VerifyOtpResponseCopyWithImpl<$Res, $Val extends VerifyOtpResponse>
    implements $VerifyOtpResponseCopyWith<$Res> {
  _$VerifyOtpResponseCopyWithImpl(this._value, this._then);

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
              as VerifyOtpData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VerifyOtpDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $VerifyOtpDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerifyOtpResponseImplCopyWith<$Res>
    implements $VerifyOtpResponseCopyWith<$Res> {
  factory _$$VerifyOtpResponseImplCopyWith(_$VerifyOtpResponseImpl value,
          $Res Function(_$VerifyOtpResponseImpl) then) =
      __$$VerifyOtpResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, VerifyOtpData? data});

  @override
  $VerifyOtpDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$VerifyOtpResponseImplCopyWithImpl<$Res>
    extends _$VerifyOtpResponseCopyWithImpl<$Res, _$VerifyOtpResponseImpl>
    implements _$$VerifyOtpResponseImplCopyWith<$Res> {
  __$$VerifyOtpResponseImplCopyWithImpl(_$VerifyOtpResponseImpl _value,
      $Res Function(_$VerifyOtpResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$VerifyOtpResponseImpl(
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
              as VerifyOtpData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyOtpResponseImpl implements _VerifyOtpResponse {
  const _$VerifyOtpResponseImpl(
      {required this.code, required this.message, this.data});

  factory _$VerifyOtpResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyOtpResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final VerifyOtpData? data;

  @override
  String toString() {
    return 'VerifyOtpResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpResponseImplCopyWith<_$VerifyOtpResponseImpl> get copyWith =>
      __$$VerifyOtpResponseImplCopyWithImpl<_$VerifyOtpResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyOtpResponseImplToJson(
      this,
    );
  }
}

abstract class _VerifyOtpResponse implements VerifyOtpResponse {
  const factory _VerifyOtpResponse(
      {required final int code,
      required final String message,
      final VerifyOtpData? data}) = _$VerifyOtpResponseImpl;

  factory _VerifyOtpResponse.fromJson(Map<String, dynamic> json) =
      _$VerifyOtpResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  VerifyOtpData? get data;
  @override
  @JsonKey(ignore: true)
  _$$VerifyOtpResponseImplCopyWith<_$VerifyOtpResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerifyOtpData _$VerifyOtpDataFromJson(Map<String, dynamic> json) {
  return _VerifyOtpData.fromJson(json);
}

/// @nodoc
mixin _$VerifyOtpData {
  VerifyOtpUser? get user => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyOtpDataCopyWith<VerifyOtpData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOtpDataCopyWith<$Res> {
  factory $VerifyOtpDataCopyWith(
          VerifyOtpData value, $Res Function(VerifyOtpData) then) =
      _$VerifyOtpDataCopyWithImpl<$Res, VerifyOtpData>;
  @useResult
  $Res call({VerifyOtpUser? user, String? token});

  $VerifyOtpUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$VerifyOtpDataCopyWithImpl<$Res, $Val extends VerifyOtpData>
    implements $VerifyOtpDataCopyWith<$Res> {
  _$VerifyOtpDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as VerifyOtpUser?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VerifyOtpUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $VerifyOtpUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerifyOtpDataImplCopyWith<$Res>
    implements $VerifyOtpDataCopyWith<$Res> {
  factory _$$VerifyOtpDataImplCopyWith(
          _$VerifyOtpDataImpl value, $Res Function(_$VerifyOtpDataImpl) then) =
      __$$VerifyOtpDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({VerifyOtpUser? user, String? token});

  @override
  $VerifyOtpUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$VerifyOtpDataImplCopyWithImpl<$Res>
    extends _$VerifyOtpDataCopyWithImpl<$Res, _$VerifyOtpDataImpl>
    implements _$$VerifyOtpDataImplCopyWith<$Res> {
  __$$VerifyOtpDataImplCopyWithImpl(
      _$VerifyOtpDataImpl _value, $Res Function(_$VerifyOtpDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? token = freezed,
  }) {
    return _then(_$VerifyOtpDataImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as VerifyOtpUser?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyOtpDataImpl implements _VerifyOtpData {
  const _$VerifyOtpDataImpl({this.user, this.token});

  factory _$VerifyOtpDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyOtpDataImplFromJson(json);

  @override
  final VerifyOtpUser? user;
  @override
  final String? token;

  @override
  String toString() {
    return 'VerifyOtpData(user: $user, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpDataImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpDataImplCopyWith<_$VerifyOtpDataImpl> get copyWith =>
      __$$VerifyOtpDataImplCopyWithImpl<_$VerifyOtpDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyOtpDataImplToJson(
      this,
    );
  }
}

abstract class _VerifyOtpData implements VerifyOtpData {
  const factory _VerifyOtpData(
      {final VerifyOtpUser? user, final String? token}) = _$VerifyOtpDataImpl;

  factory _VerifyOtpData.fromJson(Map<String, dynamic> json) =
      _$VerifyOtpDataImpl.fromJson;

  @override
  VerifyOtpUser? get user;
  @override
  String? get token;
  @override
  @JsonKey(ignore: true)
  _$$VerifyOtpDataImplCopyWith<_$VerifyOtpDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerifyOtpUser _$VerifyOtpUserFromJson(Map<String, dynamic> json) {
  return _VerifyOtpUser.fromJson(json);
}

/// @nodoc
mixin _$VerifyOtpUser {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_name')
  String? get companyName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyOtpUserCopyWith<VerifyOtpUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOtpUserCopyWith<$Res> {
  factory $VerifyOtpUserCopyWith(
          VerifyOtpUser value, $Res Function(VerifyOtpUser) then) =
      _$VerifyOtpUserCopyWithImpl<$Res, VerifyOtpUser>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'company_name') String? companyName,
      String? email,
      String? phone,
      String? category,
      int? status});
}

/// @nodoc
class _$VerifyOtpUserCopyWithImpl<$Res, $Val extends VerifyOtpUser>
    implements $VerifyOtpUserCopyWith<$Res> {
  _$VerifyOtpUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? companyName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? category = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyOtpUserImplCopyWith<$Res>
    implements $VerifyOtpUserCopyWith<$Res> {
  factory _$$VerifyOtpUserImplCopyWith(
          _$VerifyOtpUserImpl value, $Res Function(_$VerifyOtpUserImpl) then) =
      __$$VerifyOtpUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'company_name') String? companyName,
      String? email,
      String? phone,
      String? category,
      int? status});
}

/// @nodoc
class __$$VerifyOtpUserImplCopyWithImpl<$Res>
    extends _$VerifyOtpUserCopyWithImpl<$Res, _$VerifyOtpUserImpl>
    implements _$$VerifyOtpUserImplCopyWith<$Res> {
  __$$VerifyOtpUserImplCopyWithImpl(
      _$VerifyOtpUserImpl _value, $Res Function(_$VerifyOtpUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? companyName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? category = freezed,
    Object? status = freezed,
  }) {
    return _then(_$VerifyOtpUserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyOtpUserImpl implements _VerifyOtpUser {
  const _$VerifyOtpUserImpl(
      {this.id,
      this.name,
      @JsonKey(name: 'company_name') this.companyName,
      this.email,
      this.phone,
      this.category,
      this.status});

  factory _$VerifyOtpUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyOtpUserImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  @JsonKey(name: 'company_name')
  final String? companyName;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? category;
  @override
  final int? status;

  @override
  String toString() {
    return 'VerifyOtpUser(id: $id, name: $name, companyName: $companyName, email: $email, phone: $phone, category: $category, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, companyName, email, phone, category, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpUserImplCopyWith<_$VerifyOtpUserImpl> get copyWith =>
      __$$VerifyOtpUserImplCopyWithImpl<_$VerifyOtpUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyOtpUserImplToJson(
      this,
    );
  }
}

abstract class _VerifyOtpUser implements VerifyOtpUser {
  const factory _VerifyOtpUser(
      {final int? id,
      final String? name,
      @JsonKey(name: 'company_name') final String? companyName,
      final String? email,
      final String? phone,
      final String? category,
      final int? status}) = _$VerifyOtpUserImpl;

  factory _VerifyOtpUser.fromJson(Map<String, dynamic> json) =
      _$VerifyOtpUserImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(name: 'company_name')
  String? get companyName;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get category;
  @override
  int? get status;
  @override
  @JsonKey(ignore: true)
  _$$VerifyOtpUserImplCopyWith<_$VerifyOtpUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
