// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FaqResponse _$FaqResponseFromJson(Map<String, dynamic> json) {
  return _FaqResponse.fromJson(json);
}

/// @nodoc
mixin _$FaqResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<FaqModel> get data => throw _privateConstructorUsedError;
  Map<String, dynamic>? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FaqResponseCopyWith<FaqResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqResponseCopyWith<$Res> {
  factory $FaqResponseCopyWith(
          FaqResponse value, $Res Function(FaqResponse) then) =
      _$FaqResponseCopyWithImpl<$Res, FaqResponse>;
  @useResult
  $Res call(
      {int code,
      String message,
      List<FaqModel> data,
      Map<String, dynamic>? pagination});
}

/// @nodoc
class _$FaqResponseCopyWithImpl<$Res, $Val extends FaqResponse>
    implements $FaqResponseCopyWith<$Res> {
  _$FaqResponseCopyWithImpl(this._value, this._then);

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
    Object? pagination = freezed,
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
              as List<FaqModel>,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FaqResponseImplCopyWith<$Res>
    implements $FaqResponseCopyWith<$Res> {
  factory _$$FaqResponseImplCopyWith(
          _$FaqResponseImpl value, $Res Function(_$FaqResponseImpl) then) =
      __$$FaqResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int code,
      String message,
      List<FaqModel> data,
      Map<String, dynamic>? pagination});
}

/// @nodoc
class __$$FaqResponseImplCopyWithImpl<$Res>
    extends _$FaqResponseCopyWithImpl<$Res, _$FaqResponseImpl>
    implements _$$FaqResponseImplCopyWith<$Res> {
  __$$FaqResponseImplCopyWithImpl(
      _$FaqResponseImpl _value, $Res Function(_$FaqResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
    Object? pagination = freezed,
  }) {
    return _then(_$FaqResponseImpl(
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
              as List<FaqModel>,
      pagination: freezed == pagination
          ? _value._pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FaqResponseImpl implements _FaqResponse {
  const _$FaqResponseImpl(
      {required this.code,
      required this.message,
      required final List<FaqModel> data,
      final Map<String, dynamic>? pagination})
      : _data = data,
        _pagination = pagination;

  factory _$FaqResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaqResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  final List<FaqModel> _data;
  @override
  List<FaqModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  final Map<String, dynamic>? _pagination;
  @override
  Map<String, dynamic>? get pagination {
    final value = _pagination;
    if (value == null) return null;
    if (_pagination is EqualUnmodifiableMapView) return _pagination;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'FaqResponse(code: $code, message: $message, data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaqResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._pagination, _pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      message,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_pagination));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FaqResponseImplCopyWith<_$FaqResponseImpl> get copyWith =>
      __$$FaqResponseImplCopyWithImpl<_$FaqResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaqResponseImplToJson(
      this,
    );
  }
}

abstract class _FaqResponse implements FaqResponse {
  const factory _FaqResponse(
      {required final int code,
      required final String message,
      required final List<FaqModel> data,
      final Map<String, dynamic>? pagination}) = _$FaqResponseImpl;

  factory _FaqResponse.fromJson(Map<String, dynamic> json) =
      _$FaqResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  List<FaqModel> get data;
  @override
  Map<String, dynamic>? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$FaqResponseImplCopyWith<_$FaqResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FaqModel _$FaqModelFromJson(Map<String, dynamic> json) {
  return _FaqModel.fromJson(json);
}

/// @nodoc
mixin _$FaqModel {
  String get question => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FaqModelCopyWith<FaqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqModelCopyWith<$Res> {
  factory $FaqModelCopyWith(FaqModel value, $Res Function(FaqModel) then) =
      _$FaqModelCopyWithImpl<$Res, FaqModel>;
  @useResult
  $Res call({String question, String answer});
}

/// @nodoc
class _$FaqModelCopyWithImpl<$Res, $Val extends FaqModel>
    implements $FaqModelCopyWith<$Res> {
  _$FaqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answer = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FaqModelImplCopyWith<$Res>
    implements $FaqModelCopyWith<$Res> {
  factory _$$FaqModelImplCopyWith(
          _$FaqModelImpl value, $Res Function(_$FaqModelImpl) then) =
      __$$FaqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, String answer});
}

/// @nodoc
class __$$FaqModelImplCopyWithImpl<$Res>
    extends _$FaqModelCopyWithImpl<$Res, _$FaqModelImpl>
    implements _$$FaqModelImplCopyWith<$Res> {
  __$$FaqModelImplCopyWithImpl(
      _$FaqModelImpl _value, $Res Function(_$FaqModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answer = null,
  }) {
    return _then(_$FaqModelImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FaqModelImpl implements _FaqModel {
  const _$FaqModelImpl({required this.question, required this.answer});

  factory _$FaqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaqModelImplFromJson(json);

  @override
  final String question;
  @override
  final String answer;

  @override
  String toString() {
    return 'FaqModel(question: $question, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaqModelImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, question, answer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FaqModelImplCopyWith<_$FaqModelImpl> get copyWith =>
      __$$FaqModelImplCopyWithImpl<_$FaqModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaqModelImplToJson(
      this,
    );
  }
}

abstract class _FaqModel implements FaqModel {
  const factory _FaqModel(
      {required final String question,
      required final String answer}) = _$FaqModelImpl;

  factory _FaqModel.fromJson(Map<String, dynamic> json) =
      _$FaqModelImpl.fromJson;

  @override
  String get question;
  @override
  String get answer;
  @override
  @JsonKey(ignore: true)
  _$$FaqModelImplCopyWith<_$FaqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
