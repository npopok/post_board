// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      text: json['text'] as String,
      timestamp:
          const TimestampConverter().fromJson(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'author': instance.author.toJson(),
      'category': _$CategoryEnumMap[instance.category]!,
      'text': instance.text,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };

const _$CategoryEnumMap = {
  Category.sex: 'sex',
  Category.love: 'love',
  Category.services: 'services',
  Category.jobs: 'jobs',
};
