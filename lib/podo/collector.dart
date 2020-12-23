import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/fly.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tagaddod/podo/gift.dart';
import 'package:tagaddod/podo/regionRequest.dart';
import 'package:tagaddod/podo/request.dart';

part 'collector.g.dart';

@JsonSerializable()
class Collector with Parser<Collector> {
  String id;
  String name;
  String phone;
  List<Request> requests;
  int yesterday_requests;
  int month_requests;
  int today_requests;
  List<RegionRequest> regions_requests;

  Collector.empty();

  Collector(
    this.id,
    this.name,
    this.phone,
    this.requests,
    this.yesterday_requests,
    this.month_requests,
    this.today_requests,
    this.regions_requests,
  );

  factory Collector.fromJson(Map<String, dynamic> json) =>
      _$CollectorFromJson(json);

  Map<String, dynamic> toJson() => _$CollectorToJson(this);

  @override
  Collector parse(data) {
    return Collector.fromJson(data);
  }
}
