// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterImpl _$$FilterImplFromJson(Map<String, dynamic> json) => _$FilterImpl(
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: _$recordConvert(
        json['age'],
        ($jsonValue) => (
          max: $jsonValue['max'] as int,
          min: $jsonValue['min'] as int,
        ),
      ),
    );

Map<String, dynamic> _$$FilterImplToJson(_$FilterImpl instance) =>
    <String, dynamic>{
      'category': _$CategoryEnumMap[instance.category]!,
      'gender': _$GenderEnumMap[instance.gender]!,
      'age': {
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
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.couple: 'couple',
};

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
