import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tagaddod/podo/request.dart';

part 'regionRequest.g.dart';

@JsonSerializable()
class RegionRequest with Parser<RegionRequest> {
  String name;
  int total;
  List<Request> requests;

  RegionRequest.empty();
  RegionRequest(this.name, this.total, this.requests);

  factory RegionRequest.fromJson(Map<String, dynamic> json) =>
      _$RegionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegionRequestToJson(this);

  @override
  RegionRequest parse(data) {
    return RegionRequest.fromJson(data);
  }
}
