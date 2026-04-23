// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsResponse _$SettingsResponseFromJson(Map<String, dynamic> json) {
  return _SettingsResponse.fromJson(json);
}

/// @nodoc
mixin _$SettingsResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<SettingsModel> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsResponseCopyWith<SettingsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsResponseCopyWith<$Res> {
  factory $SettingsResponseCopyWith(
          SettingsResponse value, $Res Function(SettingsResponse) then) =
      _$SettingsResponseCopyWithImpl<$Res, SettingsResponse>;
  @useResult
  $Res call({int code, String message, List<SettingsModel> data});
}

/// @nodoc
class _$SettingsResponseCopyWithImpl<$Res, $Val extends SettingsResponse>
    implements $SettingsResponseCopyWith<$Res> {
  _$SettingsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
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
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SettingsModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsResponseImplCopyWith<$Res>
    implements $SettingsResponseCopyWith<$Res> {
  factory _$$SettingsResponseImplCopyWith(_$SettingsResponseImpl value,
          $Res Function(_$SettingsResponseImpl) then) =
      __$$SettingsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, List<SettingsModel> data});
}

/// @nodoc
class __$$SettingsResponseImplCopyWithImpl<$Res>
    extends _$SettingsResponseCopyWithImpl<$Res, _$SettingsResponseImpl>
    implements _$$SettingsResponseImplCopyWith<$Res> {
  __$$SettingsResponseImplCopyWithImpl(_$SettingsResponseImpl _value,
      $Res Function(_$SettingsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$SettingsResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SettingsModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsResponseImpl implements _SettingsResponse {
  const _$SettingsResponseImpl(
      {required this.code,
      required this.message,
      required final List<SettingsModel> data})
      : _data = data;

  factory _$SettingsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  final List<SettingsModel> _data;
  @override
  List<SettingsModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'SettingsResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsResponseImplCopyWith<_$SettingsResponseImpl> get copyWith =>
      __$$SettingsResponseImplCopyWithImpl<_$SettingsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsResponseImplToJson(
      this,
    );
  }
}

abstract class _SettingsResponse implements SettingsResponse {
  const factory _SettingsResponse(
      {required final int code,
      required final String message,
      required final List<SettingsModel> data}) = _$SettingsResponseImpl;

  factory _SettingsResponse.fromJson(Map<String, dynamic> json) =
      _$SettingsResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  List<SettingsModel> get data;
  @override
  @JsonKey(ignore: true)
  _$$SettingsResponseImplCopyWith<_$SettingsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) {
  return _SettingsModel.fromJson(json);
}

/// @nodoc
mixin _$SettingsModel {
  String? get name => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get metaKey => throw _privateConstructorUsedError;
  String? get metaDesc => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get whatsapp => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get support => throw _privateConstructorUsedError;
  String? get facebook => throw _privateConstructorUsedError;
  String? get xUrl => throw _privateConstructorUsedError;
  String? get youtube => throw _privateConstructorUsedError;
  String? get instagram => throw _privateConstructorUsedError;
  String? get tiktok => throw _privateConstructorUsedError;
  String? get linkedin => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get favicon => throw _privateConstructorUsedError;
  String? get copyright => throw _privateConstructorUsedError;
  String? get promotion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsModelCopyWith<SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsModelCopyWith<$Res> {
  factory $SettingsModelCopyWith(
          SettingsModel value, $Res Function(SettingsModel) then) =
      _$SettingsModelCopyWithImpl<$Res, SettingsModel>;
  @useResult
  $Res call(
      {String? name,
      String? title,
      String? desc,
      String? address,
      String? metaKey,
      String? metaDesc,
      String? phone,
      String? whatsapp,
      String? email,
      String? support,
      String? facebook,
      String? xUrl,
      String? youtube,
      String? instagram,
      String? tiktok,
      String? linkedin,
      String? logo,
      String? favicon,
      String? copyright,
      String? promotion});
}

/// @nodoc
class _$SettingsModelCopyWithImpl<$Res, $Val extends SettingsModel>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? title = freezed,
    Object? desc = freezed,
    Object? address = freezed,
    Object? metaKey = freezed,
    Object? metaDesc = freezed,
    Object? phone = freezed,
    Object? whatsapp = freezed,
    Object? email = freezed,
    Object? support = freezed,
    Object? facebook = freezed,
    Object? xUrl = freezed,
    Object? youtube = freezed,
    Object? instagram = freezed,
    Object? tiktok = freezed,
    Object? linkedin = freezed,
    Object? logo = freezed,
    Object? favicon = freezed,
    Object? copyright = freezed,
    Object? promotion = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      metaKey: freezed == metaKey
          ? _value.metaKey
          : metaKey // ignore: cast_nullable_to_non_nullable
              as String?,
      metaDesc: freezed == metaDesc
          ? _value.metaDesc
          : metaDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      whatsapp: freezed == whatsapp
          ? _value.whatsapp
          : whatsapp // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      support: freezed == support
          ? _value.support
          : support // ignore: cast_nullable_to_non_nullable
              as String?,
      facebook: freezed == facebook
          ? _value.facebook
          : facebook // ignore: cast_nullable_to_non_nullable
              as String?,
      xUrl: freezed == xUrl
          ? _value.xUrl
          : xUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as String?,
      instagram: freezed == instagram
          ? _value.instagram
          : instagram // ignore: cast_nullable_to_non_nullable
              as String?,
      tiktok: freezed == tiktok
          ? _value.tiktok
          : tiktok // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedin: freezed == linkedin
          ? _value.linkedin
          : linkedin // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      favicon: freezed == favicon
          ? _value.favicon
          : favicon // ignore: cast_nullable_to_non_nullable
              as String?,
      copyright: freezed == copyright
          ? _value.copyright
          : copyright // ignore: cast_nullable_to_non_nullable
              as String?,
      promotion: freezed == promotion
          ? _value.promotion
          : promotion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsModelImplCopyWith<$Res>
    implements $SettingsModelCopyWith<$Res> {
  factory _$$SettingsModelImplCopyWith(
          _$SettingsModelImpl value, $Res Function(_$SettingsModelImpl) then) =
      __$$SettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? title,
      String? desc,
      String? address,
      String? metaKey,
      String? metaDesc,
      String? phone,
      String? whatsapp,
      String? email,
      String? support,
      String? facebook,
      String? xUrl,
      String? youtube,
      String? instagram,
      String? tiktok,
      String? linkedin,
      String? logo,
      String? favicon,
      String? copyright,
      String? promotion});
}

/// @nodoc
class __$$SettingsModelImplCopyWithImpl<$Res>
    extends _$SettingsModelCopyWithImpl<$Res, _$SettingsModelImpl>
    implements _$$SettingsModelImplCopyWith<$Res> {
  __$$SettingsModelImplCopyWithImpl(
      _$SettingsModelImpl _value, $Res Function(_$SettingsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? title = freezed,
    Object? desc = freezed,
    Object? address = freezed,
    Object? metaKey = freezed,
    Object? metaDesc = freezed,
    Object? phone = freezed,
    Object? whatsapp = freezed,
    Object? email = freezed,
    Object? support = freezed,
    Object? facebook = freezed,
    Object? xUrl = freezed,
    Object? youtube = freezed,
    Object? instagram = freezed,
    Object? tiktok = freezed,
    Object? linkedin = freezed,
    Object? logo = freezed,
    Object? favicon = freezed,
    Object? copyright = freezed,
    Object? promotion = freezed,
  }) {
    return _then(_$SettingsModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      metaKey: freezed == metaKey
          ? _value.metaKey
          : metaKey // ignore: cast_nullable_to_non_nullable
              as String?,
      metaDesc: freezed == metaDesc
          ? _value.metaDesc
          : metaDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      whatsapp: freezed == whatsapp
          ? _value.whatsapp
          : whatsapp // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      support: freezed == support
          ? _value.support
          : support // ignore: cast_nullable_to_non_nullable
              as String?,
      facebook: freezed == facebook
          ? _value.facebook
          : facebook // ignore: cast_nullable_to_non_nullable
              as String?,
      xUrl: freezed == xUrl
          ? _value.xUrl
          : xUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as String?,
      instagram: freezed == instagram
          ? _value.instagram
          : instagram // ignore: cast_nullable_to_non_nullable
              as String?,
      tiktok: freezed == tiktok
          ? _value.tiktok
          : tiktok // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedin: freezed == linkedin
          ? _value.linkedin
          : linkedin // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      favicon: freezed == favicon
          ? _value.favicon
          : favicon // ignore: cast_nullable_to_non_nullable
              as String?,
      copyright: freezed == copyright
          ? _value.copyright
          : copyright // ignore: cast_nullable_to_non_nullable
              as String?,
      promotion: freezed == promotion
          ? _value.promotion
          : promotion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsModelImpl implements _SettingsModel {
  const _$SettingsModelImpl(
      {this.name,
      this.title,
      this.desc,
      this.address,
      this.metaKey,
      this.metaDesc,
      this.phone,
      this.whatsapp,
      this.email,
      this.support,
      this.facebook,
      this.xUrl,
      this.youtube,
      this.instagram,
      this.tiktok,
      this.linkedin,
      this.logo,
      this.favicon,
      this.copyright,
      this.promotion});

  factory _$SettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsModelImplFromJson(json);

  @override
  final String? name;
  @override
  final String? title;
  @override
  final String? desc;
  @override
  final String? address;
  @override
  final String? metaKey;
  @override
  final String? metaDesc;
  @override
  final String? phone;
  @override
  final String? whatsapp;
  @override
  final String? email;
  @override
  final String? support;
  @override
  final String? facebook;
  @override
  final String? xUrl;
  @override
  final String? youtube;
  @override
  final String? instagram;
  @override
  final String? tiktok;
  @override
  final String? linkedin;
  @override
  final String? logo;
  @override
  final String? favicon;
  @override
  final String? copyright;
  @override
  final String? promotion;

  @override
  String toString() {
    return 'SettingsModel(name: $name, title: $title, desc: $desc, address: $address, metaKey: $metaKey, metaDesc: $metaDesc, phone: $phone, whatsapp: $whatsapp, email: $email, support: $support, facebook: $facebook, xUrl: $xUrl, youtube: $youtube, instagram: $instagram, tiktok: $tiktok, linkedin: $linkedin, logo: $logo, favicon: $favicon, copyright: $copyright, promotion: $promotion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.metaKey, metaKey) || other.metaKey == metaKey) &&
            (identical(other.metaDesc, metaDesc) ||
                other.metaDesc == metaDesc) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.whatsapp, whatsapp) ||
                other.whatsapp == whatsapp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.support, support) || other.support == support) &&
            (identical(other.facebook, facebook) ||
                other.facebook == facebook) &&
            (identical(other.xUrl, xUrl) || other.xUrl == xUrl) &&
            (identical(other.youtube, youtube) || other.youtube == youtube) &&
            (identical(other.instagram, instagram) ||
                other.instagram == instagram) &&
            (identical(other.tiktok, tiktok) || other.tiktok == tiktok) &&
            (identical(other.linkedin, linkedin) ||
                other.linkedin == linkedin) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.favicon, favicon) || other.favicon == favicon) &&
            (identical(other.copyright, copyright) ||
                other.copyright == copyright) &&
            (identical(other.promotion, promotion) ||
                other.promotion == promotion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        title,
        desc,
        address,
        metaKey,
        metaDesc,
        phone,
        whatsapp,
        email,
        support,
        facebook,
        xUrl,
        youtube,
        instagram,
        tiktok,
        linkedin,
        logo,
        favicon,
        copyright,
        promotion
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsModelImplCopyWith<_$SettingsModelImpl> get copyWith =>
      __$$SettingsModelImplCopyWithImpl<_$SettingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsModelImplToJson(
      this,
    );
  }
}

abstract class _SettingsModel implements SettingsModel {
  const factory _SettingsModel(
      {final String? name,
      final String? title,
      final String? desc,
      final String? address,
      final String? metaKey,
      final String? metaDesc,
      final String? phone,
      final String? whatsapp,
      final String? email,
      final String? support,
      final String? facebook,
      final String? xUrl,
      final String? youtube,
      final String? instagram,
      final String? tiktok,
      final String? linkedin,
      final String? logo,
      final String? favicon,
      final String? copyright,
      final String? promotion}) = _$SettingsModelImpl;

  factory _SettingsModel.fromJson(Map<String, dynamic> json) =
      _$SettingsModelImpl.fromJson;

  @override
  String? get name;
  @override
  String? get title;
  @override
  String? get desc;
  @override
  String? get address;
  @override
  String? get metaKey;
  @override
  String? get metaDesc;
  @override
  String? get phone;
  @override
  String? get whatsapp;
  @override
  String? get email;
  @override
  String? get support;
  @override
  String? get facebook;
  @override
  String? get xUrl;
  @override
  String? get youtube;
  @override
  String? get instagram;
  @override
  String? get tiktok;
  @override
  String? get linkedin;
  @override
  String? get logo;
  @override
  String? get favicon;
  @override
  String? get copyright;
  @override
  String? get promotion;
  @override
  @JsonKey(ignore: true)
  _$$SettingsModelImplCopyWith<_$SettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
