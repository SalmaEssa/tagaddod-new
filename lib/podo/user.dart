import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User with Parser<User> implements  AuthUser {
  String id;
  String token;

  User.empty();

  User({this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String expire;

  @override
  String jwtToken;

  @override
  String role;

  @override
  String type;

  @override
  AuthUser fromJson(Map<String, dynamic> data) {
    return _$UserFromJson(data);
  }

  @override
  User parse(data) {
    return _$UserFromJson(data);
  }
}
