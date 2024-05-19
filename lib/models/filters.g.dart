// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FiltersImpl _$$FiltersImplFromJson(Map<String, dynamic> json) =>
    _$FiltersImpl(
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: _$recordConvert(
        json['age'],
        ($jsonValue) => (
          max: ($jsonValue['max'] as num).toInt(),
          min: ($jsonValue['min'] as num).toInt(),
        ),
      ),
    );

Map<String, dynamic> _$$FiltersImplToJson(_$FiltersImpl instance) =>
    <String, dynamic>{
      'city': instance.city.toJson(),
      'category': _$CategoryEnumMap[instance.category]!,
      'gender': _$GenderEnumMap[instance.gender]!,
      'age': <String, dynamic>{
        'max': instance.age.max,
        'min': instance.age.min,
      },
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

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
