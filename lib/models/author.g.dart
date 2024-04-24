// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorImpl _$$AuthorImplFromJson(Map<String, dynamic> json) => _$AuthorImpl(
      name: json['name'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: json['age'] as int,
      city: json['city'] as String,
      contact: json['contact'] as String,
    );

Map<String, dynamic> _$$AuthorImplToJson(_$AuthorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender]!,
      'age': instance.age,
      'city': instance.city,
      'contact': instance.contact,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};
