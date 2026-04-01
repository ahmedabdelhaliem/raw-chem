// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'static_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StaticPageResponse _$StaticPageResponseFromJson(Map<String, dynamic> json) {
  return _StaticPageResponse.fromJson(json);
}

/// @nodoc
mixin _$StaticPageResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  StaticPageData? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StaticPageResponseCopyWith<StaticPageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaticPageResponseCopyWith<$Res> {
  factory $StaticPageResponseCopyWith(
          StaticPageResponse value, $Res Function(StaticPageResponse) then) =
      _$StaticPageResponseCopyWithImpl<$Res, StaticPageResponse>;
  @useResult
  $Res call({int code, String message, StaticPageData? data});

  $StaticPageDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$StaticPageResponseCopyWithImpl<$Res, $Val extends StaticPageResponse>
    implements $StaticPageResponseCopyWith<$Res> {
  _$StaticPageResponseCopyWithImpl(this._value, this._then);

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
              as StaticPageData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StaticPageDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $StaticPageDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StaticPageResponseImplCopyWith<$Res>
    implements $StaticPageResponseCopyWith<$Res> {
  factory _$$StaticPageResponseImplCopyWith(_$StaticPageResponseImpl value,
          $Res Function(_$StaticPageResponseImpl) then) =
      __$$StaticPageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, StaticPageData? data});

  @override
  $StaticPageDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$StaticPageResponseImplCopyWithImpl<$Res>
    extends _$StaticPageResponseCopyWithImpl<$Res, _$StaticPageResponseImpl>
    implements _$$StaticPageResponseImplCopyWith<$Res> {
  __$$StaticPageResponseImplCopyWithImpl(_$StaticPageResponseImpl _value,
      $Res Function(_$StaticPageResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$StaticPageResponseImpl(
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
              as StaticPageData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StaticPageResponseImpl implements _StaticPageResponse {
  const _$StaticPageResponseImpl(
      {required this.code, required this.message, this.data});

  factory _$StaticPageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaticPageResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final StaticPageData? data;

  @override
  String toString() {
    return 'StaticPageResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaticPageResponseImpl &&
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
  _$$StaticPageResponseImplCopyWith<_$StaticPageResponseImpl> get copyWith =>
      __$$StaticPageResponseImplCopyWithImpl<_$StaticPageResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaticPageResponseImplToJson(
      this,
    );
  }
}

abstract class _StaticPageResponse implements StaticPageResponse {
  const factory _StaticPageResponse(
      {required final int code,
      required final String message,
      final StaticPageData? data}) = _$StaticPageResponseImpl;

  factory _StaticPageResponse.fromJson(Map<String, dynamic> json) =
      _$StaticPageResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  StaticPageData? get data;
  @override
  @JsonKey(ignore: true)
  _$$StaticPageResponseImplCopyWith<_$StaticPageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StaticPageData _$StaticPageDataFromJson(Map<String, dynamic> json) {
  return _StaticPageData.fromJson(json);
}

/// @nodoc
mixin _$StaticPageData {
  String? get banner => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StaticPageDataCopyWith<StaticPageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaticPageDataCopyWith<$Res> {
  factory $StaticPageDataCopyWith(
          StaticPageData value, $Res Function(StaticPageData) then) =
      _$StaticPageDataCopyWithImpl<$Res, StaticPageData>;
  @useResult
  $Res call(
      {String? banner,
      String? title,
      String? description,
      String? image,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$StaticPageDataCopyWithImpl<$Res, $Val extends StaticPageData>
    implements $StaticPageDataCopyWith<$Res> {
  _$StaticPageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? banner = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaticPageDataImplCopyWith<$Res>
    implements $StaticPageDataCopyWith<$Res> {
  factory _$$StaticPageDataImplCopyWith(_$StaticPageDataImpl value,
          $Res Function(_$StaticPageDataImpl) then) =
      __$$StaticPageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? banner,
      String? title,
      String? description,
      String? image,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$StaticPageDataImplCopyWithImpl<$Res>
    extends _$StaticPageDataCopyWithImpl<$Res, _$StaticPageDataImpl>
    implements _$$StaticPageDataImplCopyWith<$Res> {
  __$$StaticPageDataImplCopyWithImpl(
      _$StaticPageDataImpl _value, $Res Function(_$StaticPageDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? banner = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StaticPageDataImpl(
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StaticPageDataImpl implements _StaticPageData {
  const _$StaticPageDataImpl(
      {this.banner,
      this.title,
      this.description,
      this.image,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$StaticPageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaticPageDataImplFromJson(json);

  @override
  final String? banner;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? image;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'StaticPageData(banner: $banner, title: $title, description: $description, image: $image, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaticPageDataImpl &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, banner, title, description, image, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StaticPageDataImplCopyWith<_$StaticPageDataImpl> get copyWith =>
      __$$StaticPageDataImplCopyWithImpl<_$StaticPageDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaticPageDataImplToJson(
      this,
    );
  }
}

abstract class _StaticPageData implements StaticPageData {
  const factory _StaticPageData(
          {final String? banner,
          final String? title,
          final String? description,
          final String? image,
          @JsonKey(name: 'updated_at') final String? updatedAt}) =
      _$StaticPageDataImpl;

  factory _StaticPageData.fromJson(Map<String, dynamic> json) =
      _$StaticPageDataImpl.fromJson;

  @override
  String? get banner;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get image;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$StaticPageDataImplCopyWith<_$StaticPageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
