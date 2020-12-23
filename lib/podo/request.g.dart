// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) {
  return Request(
    json['id'] as String,
    json['collector'] == null
        ? null
        : Collector.fromJson(json['collector'] as Map<String, dynamic>),
    json['gift'] == null
        ? null
        : Gift.fromJson(json['gift'] as Map<String, dynamic>),
    json['status'] as String,
    json['collection_date'] == null
        ? null
        : DateTime.parse(json['collection_date'] as String),
    json['notes'] as String,
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['collected_quantity'] as int,
    json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['complain'] == null
        ? null
        : Complain.fromJson(json['complain'] as Map<String, dynamic>),
  )
    ..querys = (json['querys'] as List)?.map((e) => e as String)?.toList()
    ..rated_by_collector = json['rated_by_collector'] as bool
    ..rated_by_customer = json['rated_by_customer'] as bool
    ..customerRating = json['customerRating'] == null
        ? null
        : CustomerRating.fromJson(
            json['customerRating'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'collector': instance.collector,
      'gift': instance.gift,
      'status': instance.status,
      'collection_date': instance.collection_date?.toIso8601String(),
      'notes': instance.notes,
      'created_at': instance.created_at?.toIso8601String(),
      'collected_quantity': instance.collected_quantity,
      'customer': instance.customer,
      'address': instance.address,
      'rated_by_collector': instance.rated_by_collector,
      'rated_by_customer': instance.rated_by_customer,
      'customerRating': instance.customerRating,
      'complain': instance.complain,
    };
