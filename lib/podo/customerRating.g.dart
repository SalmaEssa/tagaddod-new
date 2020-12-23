// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerRating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerRating _$CustomerRatingFromJson(Map<String, dynamic> json) {
  return CustomerRating(
    json['rate'] as int,
    json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    json['request'] == null
        ? null
        : Request.fromJson(json['request'] as Map<String, dynamic>),
    json['status'] as String,
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CustomerRatingToJson(CustomerRating instance) =>
    <String, dynamic>{
      'querys': instance.querys,
      'rate': instance.rate,
      'customer': instance.customer,
      'request': instance.request,
      'status': instance.status,
    };
