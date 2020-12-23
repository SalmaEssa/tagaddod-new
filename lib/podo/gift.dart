import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';

part'gift.g.dart';

@JsonSerializable()
class Gift with Parser<Gift>{
  String id;
  String name;
  int level;

  Gift.empty();
  Gift(
    this.id,
    this.name,
    this.level,
  );

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);

  Map<String, dynamic> toJson() => _$GiftToJson(this);

  @override
  Gift parse(data) {
    return Gift.fromJson(data);
  }
}