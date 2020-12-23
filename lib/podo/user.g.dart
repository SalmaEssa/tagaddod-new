// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  print("jsonisss");
  print(json);
  return User(
    token: json['token'] as String,
  )
    ..querys = (json['querys'] as List)?.map((e) => e as String)?.toList()
    ..id = json['id'] as String
    ..expire = json['expire'] as String
    ..jwtToken = json['jwtToken'] as String
    ..role = json['role'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'querys': instance.querys,
      'id': instance.id,
      'token': instance.token,
      'expire': instance.expire,
      'jwtToken': instance.jwtToken,
      'role': instance.role,
      'type': instance.type,
    };
