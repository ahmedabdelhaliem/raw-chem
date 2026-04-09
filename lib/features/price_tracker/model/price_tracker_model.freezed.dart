// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_tracker_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PriceTrackerModel _$PriceTrackerModelFromJson(Map<String, dynamic> json) {
  return _PriceTrackerModel.fromJson(json);
}

/// @nodoc
mixin _$PriceTrackerModel {
  int get id => throw _privateConstructorUsedError;
  SupplierModel? get supplier => throw _privateConstructorUsedError;
  MaterialFamilyModel? get family => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'cas_number')
  String? get casNumber => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_price')
  String? get minPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_price')
  String? get maxPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_price')
  String? get averagePrice => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceTrackerModelCopyWith<PriceTrackerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceTrackerModelCopyWith<$Res> {
  factory $PriceTrackerModelCopyWith(
          PriceTrackerModel value, $Res Function(PriceTrackerModel) then) =
      _$PriceTrackerModelCopyWithImpl<$Res, PriceTrackerModel>;
  @useResult
  $Res call(
      {int id,
      SupplierModel? supplier,
      MaterialFamilyModel? family,
      String? name,
      @JsonKey(name: 'cas_number') String? casNumber,
      String? description,
      String? image,
      @JsonKey(name: 'min_price') String? minPrice,
      @JsonKey(name: 'max_price') String? maxPrice,
      @JsonKey(name: 'average_price') String? averagePrice,
      String? date});

  $SupplierModelCopyWith<$Res>? get supplier;
  $MaterialFamilyModelCopyWith<$Res>? get family;
}

/// @nodoc
class _$PriceTrackerModelCopyWithImpl<$Res, $Val extends PriceTrackerModel>
    implements $PriceTrackerModelCopyWith<$Res> {
  _$PriceTrackerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? supplier = freezed,
    Object? family = freezed,
    Object? name = freezed,
    Object? casNumber = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? averagePrice = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as SupplierModel?,
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
      minPrice: freezed == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPrice: freezed == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      averagePrice: freezed == averagePrice
          ? _value.averagePrice
          : averagePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SupplierModelCopyWith<$Res>? get supplier {
    if (_value.supplier == null) {
      return null;
    }

    return $SupplierModelCopyWith<$Res>(_value.supplier!, (value) {
      return _then(_value.copyWith(supplier: value) as $Val);
    });
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
abstract class _$$PriceTrackerModelImplCopyWith<$Res>
    implements $PriceTrackerModelCopyWith<$Res> {
  factory _$$PriceTrackerModelImplCopyWith(_$PriceTrackerModelImpl value,
          $Res Function(_$PriceTrackerModelImpl) then) =
      __$$PriceTrackerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      SupplierModel? supplier,
      MaterialFamilyModel? family,
      String? name,
      @JsonKey(name: 'cas_number') String? casNumber,
      String? description,
      String? image,
      @JsonKey(name: 'min_price') String? minPrice,
      @JsonKey(name: 'max_price') String? maxPrice,
      @JsonKey(name: 'average_price') String? averagePrice,
      String? date});

  @override
  $SupplierModelCopyWith<$Res>? get supplier;
  @override
  $MaterialFamilyModelCopyWith<$Res>? get family;
}

/// @nodoc
class __$$PriceTrackerModelImplCopyWithImpl<$Res>
    extends _$PriceTrackerModelCopyWithImpl<$Res, _$PriceTrackerModelImpl>
    implements _$$PriceTrackerModelImplCopyWith<$Res> {
  __$$PriceTrackerModelImplCopyWithImpl(_$PriceTrackerModelImpl _value,
      $Res Function(_$PriceTrackerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? supplier = freezed,
    Object? family = freezed,
    Object? name = freezed,
    Object? casNumber = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? averagePrice = freezed,
    Object? date = freezed,
  }) {
    return _then(_$PriceTrackerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as SupplierModel?,
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
      minPrice: freezed == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPrice: freezed == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      averagePrice: freezed == averagePrice
          ? _value.averagePrice
          : averagePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceTrackerModelImpl extends _PriceTrackerModel {
  const _$PriceTrackerModelImpl(
      {required this.id,
      this.supplier,
      this.family,
      this.name,
      @JsonKey(name: 'cas_number') this.casNumber,
      this.description,
      this.image,
      @JsonKey(name: 'min_price') this.minPrice,
      @JsonKey(name: 'max_price') this.maxPrice,
      @JsonKey(name: 'average_price') this.averagePrice,
      this.date})
      : super._();

  factory _$PriceTrackerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceTrackerModelImplFromJson(json);

  @override
  final int id;
  @override
  final SupplierModel? supplier;
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
  @JsonKey(name: 'min_price')
  final String? minPrice;
  @override
  @JsonKey(name: 'max_price')
  final String? maxPrice;
  @override
  @JsonKey(name: 'average_price')
  final String? averagePrice;
  @override
  final String? date;

  @override
  String toString() {
    return 'PriceTrackerModel(id: $id, supplier: $supplier, family: $family, name: $name, casNumber: $casNumber, description: $description, image: $image, minPrice: $minPrice, maxPrice: $maxPrice, averagePrice: $averagePrice, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceTrackerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.casNumber, casNumber) ||
                other.casNumber == casNumber) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.averagePrice, averagePrice) ||
                other.averagePrice == averagePrice) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, supplier, family, name,
      casNumber, description, image, minPrice, maxPrice, averagePrice, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceTrackerModelImplCopyWith<_$PriceTrackerModelImpl> get copyWith =>
      __$$PriceTrackerModelImplCopyWithImpl<_$PriceTrackerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceTrackerModelImplToJson(
      this,
    );
  }
}

abstract class _PriceTrackerModel extends PriceTrackerModel {
  const factory _PriceTrackerModel(
      {required final int id,
      final SupplierModel? supplier,
      final MaterialFamilyModel? family,
      final String? name,
      @JsonKey(name: 'cas_number') final String? casNumber,
      final String? description,
      final String? image,
      @JsonKey(name: 'min_price') final String? minPrice,
      @JsonKey(name: 'max_price') final String? maxPrice,
      @JsonKey(name: 'average_price') final String? averagePrice,
      final String? date}) = _$PriceTrackerModelImpl;
  const _PriceTrackerModel._() : super._();

  factory _PriceTrackerModel.fromJson(Map<String, dynamic> json) =
      _$PriceTrackerModelImpl.fromJson;

  @override
  int get id;
  @override
  SupplierModel? get supplier;
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
  @JsonKey(name: 'min_price')
  String? get minPrice;
  @override
  @JsonKey(name: 'max_price')
  String? get maxPrice;
  @override
  @JsonKey(name: 'average_price')
  String? get averagePrice;
  @override
  String? get date;
  @override
  @JsonKey(ignore: true)
  _$$PriceTrackerModelImplCopyWith<_$PriceTrackerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
