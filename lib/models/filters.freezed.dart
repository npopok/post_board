// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Filters _$FiltersFromJson(Map<String, dynamic> json) {
  return _Filters.fromJson(json);
}

/// @nodoc
mixin _$Filters {
  Category get category => throw _privateConstructorUsedError;
  Gender get gender => throw _privateConstructorUsedError;
  @NumericRangeConverter()
  ({int max, int min}) get age => throw _privateConstructorUsedError;
  City get city => throw _privateConstructorUsedError;
  int? get distance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FiltersCopyWith<Filters> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FiltersCopyWith<$Res> {
  factory $FiltersCopyWith(Filters value, $Res Function(Filters) then) =
      _$FiltersCopyWithImpl<$Res, Filters>;
  @useResult
  $Res call(
      {Category category,
      Gender gender,
      @NumericRangeConverter() ({int max, int min}) age,
      City city,
      int? distance});

  $CityCopyWith<$Res> get city;
}

/// @nodoc
class _$FiltersCopyWithImpl<$Res, $Val extends Filters>
    implements $FiltersCopyWith<$Res> {
  _$FiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? gender = null,
    Object? age = null,
    Object? city = null,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as ({int max, int min}),
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as City,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CityCopyWith<$Res> get city {
    return $CityCopyWith<$Res>(_value.city, (value) {
      return _then(_value.copyWith(city: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FiltersImplCopyWith<$Res> implements $FiltersCopyWith<$Res> {
  factory _$$FiltersImplCopyWith(
          _$FiltersImpl value, $Res Function(_$FiltersImpl) then) =
      __$$FiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Category category,
      Gender gender,
      @NumericRangeConverter() ({int max, int min}) age,
      City city,
      int? distance});

  @override
  $CityCopyWith<$Res> get city;
}

/// @nodoc
class __$$FiltersImplCopyWithImpl<$Res>
    extends _$FiltersCopyWithImpl<$Res, _$FiltersImpl>
    implements _$$FiltersImplCopyWith<$Res> {
  __$$FiltersImplCopyWithImpl(
      _$FiltersImpl _value, $Res Function(_$FiltersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? gender = null,
    Object? age = null,
    Object? city = null,
    Object? distance = freezed,
  }) {
    return _then(_$FiltersImpl(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as ({int max, int min}),
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as City,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FiltersImpl extends _Filters {
  const _$FiltersImpl(
      {required this.category,
      required this.gender,
      @NumericRangeConverter() required this.age,
      required this.city,
      this.distance = DefaultSettings.distance})
      : super._();

  factory _$FiltersImpl.fromJson(Map<String, dynamic> json) =>
      _$$FiltersImplFromJson(json);

  @override
  final Category category;
  @override
  final Gender gender;
  @override
  @NumericRangeConverter()
  final ({int max, int min}) age;
  @override
  final City city;
  @override
  @JsonKey()
  final int? distance;

  @override
  String toString() {
    return 'Filters(category: $category, gender: $gender, age: $age, city: $city, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiltersImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, category, gender, age, city, distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FiltersImplCopyWith<_$FiltersImpl> get copyWith =>
      __$$FiltersImplCopyWithImpl<_$FiltersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FiltersImplToJson(
      this,
    );
  }
}

abstract class _Filters extends Filters {
  const factory _Filters(
      {required final Category category,
      required final Gender gender,
      @NumericRangeConverter() required final ({int max, int min}) age,
      required final City city,
      final int? distance}) = _$FiltersImpl;
  const _Filters._() : super._();

  factory _Filters.fromJson(Map<String, dynamic> json) = _$FiltersImpl.fromJson;

  @override
  Category get category;
  @override
  Gender get gender;
  @override
  @NumericRangeConverter()
  ({int max, int min}) get age;
  @override
  City get city;
  @override
  int? get distance;
  @override
  @JsonKey(ignore: true)
  _$$FiltersImplCopyWith<_$FiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
