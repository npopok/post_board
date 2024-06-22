// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FiltersImpl _$$FiltersImplFromJson(Map<String, dynamic> json) =>
    _$FiltersImpl(
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: const NumericRangeConverter().fromJson(json['age'] as String),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toInt() ?? DefaultSettings.distance,
    );

Map<String, dynamic> _$$FiltersImplToJson(_$FiltersImpl instance) =>
    <String, dynamic>{
      'category': _$CategoryEnumMap[instance.category]!,
      'gender': _$GenderEnumMap[instance.gender]!,
      'age': const NumericRangeConverter().toJson(instance.age),
      'city': instance.city.toJson(),
      'distance': instance.distance,
    };

const _$CategoryEnumMap = {
  Category.sex: 'sex',
  Category.love: 'love',
  Category.services: 'services',
  Category.jobs: 'jobs',
  Category.other: 'other',
};

const _$GenderEnumMap = {
  Gender.unknown: 'unknown',
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.couple: 'couple',
};
