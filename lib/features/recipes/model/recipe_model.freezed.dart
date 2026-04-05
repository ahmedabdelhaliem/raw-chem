// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeResponse _$RecipeResponseFromJson(Map<String, dynamic> json) {
  return _RecipeResponse.fromJson(json);
}

/// @nodoc
mixin _$RecipeResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<RecipeModel> get data => throw _privateConstructorUsedError;
  PaginationModel? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeResponseCopyWith<RecipeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeResponseCopyWith<$Res> {
  factory $RecipeResponseCopyWith(
          RecipeResponse value, $Res Function(RecipeResponse) then) =
      _$RecipeResponseCopyWithImpl<$Res, RecipeResponse>;
  @useResult
  $Res call(
      {int code,
      String message,
      List<RecipeModel> data,
      PaginationModel? pagination});

  $PaginationModelCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$RecipeResponseCopyWithImpl<$Res, $Val extends RecipeResponse>
    implements $RecipeResponseCopyWith<$Res> {
  _$RecipeResponseCopyWithImpl(this._value, this._then);

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
              as List<RecipeModel>,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationModelCopyWith<$Res>(_value.pagination!, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecipeResponseImplCopyWith<$Res>
    implements $RecipeResponseCopyWith<$Res> {
  factory _$$RecipeResponseImplCopyWith(_$RecipeResponseImpl value,
          $Res Function(_$RecipeResponseImpl) then) =
      __$$RecipeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int code,
      String message,
      List<RecipeModel> data,
      PaginationModel? pagination});

  @override
  $PaginationModelCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$RecipeResponseImplCopyWithImpl<$Res>
    extends _$RecipeResponseCopyWithImpl<$Res, _$RecipeResponseImpl>
    implements _$$RecipeResponseImplCopyWith<$Res> {
  __$$RecipeResponseImplCopyWithImpl(
      _$RecipeResponseImpl _value, $Res Function(_$RecipeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
    Object? pagination = freezed,
  }) {
    return _then(_$RecipeResponseImpl(
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
              as List<RecipeModel>,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeResponseImpl implements _RecipeResponse {
  const _$RecipeResponseImpl(
      {required this.code,
      required this.message,
      required final List<RecipeModel> data,
      this.pagination})
      : _data = data;

  factory _$RecipeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  final List<RecipeModel> _data;
  @override
  List<RecipeModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationModel? pagination;

  @override
  String toString() {
    return 'RecipeResponse(code: $code, message: $message, data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message,
      const DeepCollectionEquality().hash(_data), pagination);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeResponseImplCopyWith<_$RecipeResponseImpl> get copyWith =>
      __$$RecipeResponseImplCopyWithImpl<_$RecipeResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeResponseImplToJson(
      this,
    );
  }
}

abstract class _RecipeResponse implements RecipeResponse {
  const factory _RecipeResponse(
      {required final int code,
      required final String message,
      required final List<RecipeModel> data,
      final PaginationModel? pagination}) = _$RecipeResponseImpl;

  factory _RecipeResponse.fromJson(Map<String, dynamic> json) =
      _$RecipeResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  List<RecipeModel> get data;
  @override
  PaginationModel? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$RecipeResponseImplCopyWith<_$RecipeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipeDetailsResponse _$RecipeDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return _RecipeDetailsResponse.fromJson(json);
}

/// @nodoc
mixin _$RecipeDetailsResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  RecipeModel get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeDetailsResponseCopyWith<RecipeDetailsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeDetailsResponseCopyWith<$Res> {
  factory $RecipeDetailsResponseCopyWith(RecipeDetailsResponse value,
          $Res Function(RecipeDetailsResponse) then) =
      _$RecipeDetailsResponseCopyWithImpl<$Res, RecipeDetailsResponse>;
  @useResult
  $Res call({int code, String message, RecipeModel data});

  $RecipeModelCopyWith<$Res> get data;
}

/// @nodoc
class _$RecipeDetailsResponseCopyWithImpl<$Res,
        $Val extends RecipeDetailsResponse>
    implements $RecipeDetailsResponseCopyWith<$Res> {
  _$RecipeDetailsResponseCopyWithImpl(this._value, this._then);

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
              as RecipeModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecipeModelCopyWith<$Res> get data {
    return $RecipeModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecipeDetailsResponseImplCopyWith<$Res>
    implements $RecipeDetailsResponseCopyWith<$Res> {
  factory _$$RecipeDetailsResponseImplCopyWith(
          _$RecipeDetailsResponseImpl value,
          $Res Function(_$RecipeDetailsResponseImpl) then) =
      __$$RecipeDetailsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, RecipeModel data});

  @override
  $RecipeModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$RecipeDetailsResponseImplCopyWithImpl<$Res>
    extends _$RecipeDetailsResponseCopyWithImpl<$Res,
        _$RecipeDetailsResponseImpl>
    implements _$$RecipeDetailsResponseImplCopyWith<$Res> {
  __$$RecipeDetailsResponseImplCopyWithImpl(_$RecipeDetailsResponseImpl _value,
      $Res Function(_$RecipeDetailsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$RecipeDetailsResponseImpl(
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
              as RecipeModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeDetailsResponseImpl implements _RecipeDetailsResponse {
  const _$RecipeDetailsResponseImpl(
      {required this.code, required this.message, required this.data});

  factory _$RecipeDetailsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeDetailsResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final RecipeModel data;

  @override
  String toString() {
    return 'RecipeDetailsResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeDetailsResponseImpl &&
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
  _$$RecipeDetailsResponseImplCopyWith<_$RecipeDetailsResponseImpl>
      get copyWith => __$$RecipeDetailsResponseImplCopyWithImpl<
          _$RecipeDetailsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeDetailsResponseImplToJson(
      this,
    );
  }
}

abstract class _RecipeDetailsResponse implements RecipeDetailsResponse {
  const factory _RecipeDetailsResponse(
      {required final int code,
      required final String message,
      required final RecipeModel data}) = _$RecipeDetailsResponseImpl;

  factory _RecipeDetailsResponse.fromJson(Map<String, dynamic> json) =
      _$RecipeDetailsResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  RecipeModel get data;
  @override
  @JsonKey(ignore: true)
  _$$RecipeDetailsResponseImplCopyWith<_$RecipeDetailsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) {
  return _RecipeModel.fromJson(json);
}

/// @nodoc
mixin _$RecipeModel {
  int get id => throw _privateConstructorUsedError;
  String? get order => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get ingredients => throw _privateConstructorUsedError;
  String? get measurements => throw _privateConstructorUsedError;
  @JsonKey(name: 'preparation_instructions')
  String? get preparationInstructions => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeModelCopyWith<RecipeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeModelCopyWith<$Res> {
  factory $RecipeModelCopyWith(
          RecipeModel value, $Res Function(RecipeModel) then) =
      _$RecipeModelCopyWithImpl<$Res, RecipeModel>;
  @useResult
  $Res call(
      {int id,
      String? order,
      String? name,
      String? description,
      String? ingredients,
      String? measurements,
      @JsonKey(name: 'preparation_instructions')
      String? preparationInstructions,
      String? image});
}

/// @nodoc
class _$RecipeModelCopyWithImpl<$Res, $Val extends RecipeModel>
    implements $RecipeModelCopyWith<$Res> {
  _$RecipeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? ingredients = freezed,
    Object? measurements = freezed,
    Object? preparationInstructions = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: freezed == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as String?,
      measurements: freezed == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as String?,
      preparationInstructions: freezed == preparationInstructions
          ? _value.preparationInstructions
          : preparationInstructions // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeModelImplCopyWith<$Res>
    implements $RecipeModelCopyWith<$Res> {
  factory _$$RecipeModelImplCopyWith(
          _$RecipeModelImpl value, $Res Function(_$RecipeModelImpl) then) =
      __$$RecipeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? order,
      String? name,
      String? description,
      String? ingredients,
      String? measurements,
      @JsonKey(name: 'preparation_instructions')
      String? preparationInstructions,
      String? image});
}

/// @nodoc
class __$$RecipeModelImplCopyWithImpl<$Res>
    extends _$RecipeModelCopyWithImpl<$Res, _$RecipeModelImpl>
    implements _$$RecipeModelImplCopyWith<$Res> {
  __$$RecipeModelImplCopyWithImpl(
      _$RecipeModelImpl _value, $Res Function(_$RecipeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? ingredients = freezed,
    Object? measurements = freezed,
    Object? preparationInstructions = freezed,
    Object? image = freezed,
  }) {
    return _then(_$RecipeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: freezed == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as String?,
      measurements: freezed == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as String?,
      preparationInstructions: freezed == preparationInstructions
          ? _value.preparationInstructions
          : preparationInstructions // ignore: cast_nullable_to_non_nullable
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
class _$RecipeModelImpl implements _RecipeModel {
  const _$RecipeModelImpl(
      {required this.id,
      this.order,
      this.name,
      this.description,
      this.ingredients,
      this.measurements,
      @JsonKey(name: 'preparation_instructions') this.preparationInstructions,
      this.image});

  factory _$RecipeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeModelImplFromJson(json);

  @override
  final int id;
  @override
  final String? order;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? ingredients;
  @override
  final String? measurements;
  @override
  @JsonKey(name: 'preparation_instructions')
  final String? preparationInstructions;
  @override
  final String? image;

  @override
  String toString() {
    return 'RecipeModel(id: $id, order: $order, name: $name, description: $description, ingredients: $ingredients, measurements: $measurements, preparationInstructions: $preparationInstructions, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ingredients, ingredients) ||
                other.ingredients == ingredients) &&
            (identical(other.measurements, measurements) ||
                other.measurements == measurements) &&
            (identical(
                    other.preparationInstructions, preparationInstructions) ||
                other.preparationInstructions == preparationInstructions) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, order, name, description,
      ingredients, measurements, preparationInstructions, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      __$$RecipeModelImplCopyWithImpl<_$RecipeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeModelImplToJson(
      this,
    );
  }
}

abstract class _RecipeModel implements RecipeModel {
  const factory _RecipeModel(
      {required final int id,
      final String? order,
      final String? name,
      final String? description,
      final String? ingredients,
      final String? measurements,
      @JsonKey(name: 'preparation_instructions')
      final String? preparationInstructions,
      final String? image}) = _$RecipeModelImpl;

  factory _RecipeModel.fromJson(Map<String, dynamic> json) =
      _$RecipeModelImpl.fromJson;

  @override
  int get id;
  @override
  String? get order;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get ingredients;
  @override
  String? get measurements;
  @override
  @JsonKey(name: 'preparation_instructions')
  String? get preparationInstructions;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
