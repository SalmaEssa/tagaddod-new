import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';

part'address.g.dart';

@JsonSerializable()
class Address with Parser<Address>{
  String id;
  String longitude;
  String latitude;
  String description;

  Address.empty();
  Address(
    this.id,
    this.longitude,
    this.latitude,
    this.description,
  );

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  Address parse(data) {
    return Address.fromJson(data);
  }
}