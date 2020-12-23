// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Complain _$ComplainFromJson(Map<String, dynamic> json) {
  return Complain(
    json['id'] as String,
    json['collector'] == null
        ? null
        : Collector.fromJson(json['collector'] as Map<String, dynamic>),
    json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    json['request'] == null
        ? null
        : Request.fromJson(json['request'] as Map<String, dynamic>),
    json['complainType'] == null
        ? null
        : ComplainType.fromJson(json['complainType'] as Map<String, dynamic>),
    json['complainer'] as String,
    json['description'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ComplainToJson(Complain instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'collector': instance.collector,
      'customer': instance.customer,
      'request': instance.request,
      'complainType': instance.complainType,
      'complainer': instance.complainer,
      'description': instance.description,
    };
