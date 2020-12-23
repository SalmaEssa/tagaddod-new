// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regionRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionRequest _$RegionRequestFromJson(Map<String, dynamic> json) {
  return RegionRequest(
    json['name'] as String,
    json['total'] as int,
    (json['requests'] as List)
        ?.map((e) =>
            e == null ? null : Request.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$RegionRequestToJson(RegionRequest instance) =>
    <String, dynamic>{
      'querys': instance.querys,
      'name': instance.name,
      'total': instance.total,
      'requests': instance.requests,
    };
