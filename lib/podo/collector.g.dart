// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collector _$CollectorFromJson(Map<String, dynamic> json) {
  print("jasoon file look likeeeeeeeeeeeeeeee");
  print(json);
  return Collector(
    json['id'] as String,
    json['name'] as String,
    json['phone'] as String,
    (json['requests'] as List)
        ?.map((e) =>
            e == null ? null : Request.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['yesterday_requests'] as int,
    json['month_requests'] as int,
    json['today_requests'] as int,
    (json['regions_requests'] as List)
        ?.map((e) => e == null
            ? null
            : RegionRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..querys = (json['querys'] as List)?.map((e) => e as String)?.toList();
  // collectoer is mixin with parser so when we put . we access querry
  // we put another. to make the return  is collector itself  not the list
}

Map<String, dynamic> _$CollectorToJson(Collector instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'requests': instance.requests,
      'yesterday_requests': instance.yesterday_requests,
      'month_requests': instance.month_requests,
      'today_requests': instance.today_requests,
      'regions_requests': instance.regions_requests,
    };
