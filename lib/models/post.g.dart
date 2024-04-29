// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      createdAt: DateTime.parse(json['createdAt'] as String),
      source: $enumDecode(_$SourceEnumMap, json['source']),
      author: json['author'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: json['age'] as int,
      city: json['city'] as String,
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      text: json['text'] as String,
      contact: json['contact'] as String,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'source': _$SourceEnumMap[instance.source]!,
      'author': instance.author,
      'gender': _$GenderEnumMap[instance.gender]!,
      'age': instance.age,
      'city': instance.city,
      'category': _$CategoryEnumMap[instance.category]!,
      'text': instance.text,
      'contact': instance.contact,
    };

const _$SourceEnumMap = {
  Source.user: 'user',
  Source.service: 'service',
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};

const _$CategoryEnumMap = {
  Category.sex: 'sex',
  Category.love: 'love',
  Category.services: 'services',
  Category.jobs: 'jobs',
  Category.other: 'other',
};
