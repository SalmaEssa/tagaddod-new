import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complainType.g.dart';

@JsonSerializable()
class ComplainType with Parser<ComplainType> {
  String id;
  String name;

  ComplainType.empty();
  ComplainType(
    this.id,
    this.name,
  );

  factory ComplainType.fromJson(Map<String, dynamic> json) =>
      _$ComplainTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ComplainTypeToJson(this);

  @override
  ComplainType parse(data) {
    return ComplainType.fromJson(data);
  }
}
