// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      createdAgo: (json['created_ago'] as num).toInt(),
      createdBy: json['created_by'] as String?,
      author: json['author'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: (json['age'] as num).toInt(),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      text: json['text'] as String,
      contact: const ContactConverter().fromJson(json['contact'] as String),
      location: const LocationConverter().fromJson(json['location'] as String),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'created_ago': instance.createdAgo,
      'created_by': instance.createdBy,
      'author': instance.author,
      'gender': _$GenderEnumMap[instance.gender]!,
      'age': instance.age,
      'city': instance.city.toJson(),
      'category': _$CategoryEnumMap[instance.category]!,
      'text': instance.text,
      'contact': const ContactConverter().toJson(instance.contact),
      'location': const LocationConverter().toJson(instance.location),
    };

const _$GenderEnumMap = {
  Gender.unknown: 'unknown',
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.couple: 'couple',
};

const _$CategoryEnumMap = {
  Category.sex: 'sex',
  Category.love: 'love',
  Category.services: 'services',
  Category.jobs: 'jobs',
  Category.other: 'other',
};
