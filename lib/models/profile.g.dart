// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      name: json['name'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: (json['age'] as num).toInt(),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender]!,
      'age': instance.age,
      'city': instance.city.toJson(),
      'contact': instance.contact.toJson(),
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.couple: 'couple',
};
