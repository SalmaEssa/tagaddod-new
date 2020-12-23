// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['id'] as String,
    json['longitude'] as String,
    json['latitude'] as String,
    json['description'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'description': instance.description,
    };
