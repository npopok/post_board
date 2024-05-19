// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactImpl _$$ContactImplFromJson(Map<String, dynamic> json) =>
    _$ContactImpl(
      type: $enumDecode(_$ContactTypeEnumMap, json['type']),
      details: json['details'] as String,
    );

Map<String, dynamic> _$$ContactImplToJson(_$ContactImpl instance) =>
    <String, dynamic>{
      'type': _$ContactTypeEnumMap[instance.type]!,
      'details': instance.details,
    };

const _$ContactTypeEnumMap = {
  ContactType.unknown: 'unknown',
  ContactType.email: 'email',
  ContactType.whatsapp: 'whatsapp',
  ContactType.telegram: 'telegram',
};
