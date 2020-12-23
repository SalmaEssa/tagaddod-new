// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complainType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplainType _$ComplainTypeFromJson(Map<String, dynamic> json) {
  return ComplainType(
    json['id'] as String,
    json['name'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ComplainTypeToJson(ComplainType instance) =>
    <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'name': instance.name,
    };
