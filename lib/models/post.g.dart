// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      message: json['message'] as String,
      timestamp:
          const TimestampConverter().fromJson(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'author': instance.author.toJson(),
      'message': instance.message,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
